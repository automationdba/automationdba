set markup html on
SET TERMOUT OFF;
COLUMN current_instance NEW_VALUE current_instance NOPRINT;
COLUMN db_unique_name NEW_VALUE db_unique_name NOPRINT;
COLUMN current_timestamp NEW_VALUE current_timestamp  NOPRINT;
SELECT rpad(sys_context('USERENV', 'DB_UNIQUE_NAME'),15)  db_unique_name  FROM DUAL;
SELECT rpad(instance_name, 17) current_instance,rpad(current_timestamp,22) current_timestamp FROM v$instance;
SET TERMOUT ON
set verify off
define num_days=&1
PROMPT
PROMPT +------------------------------------------------------------------------------------------------+
PROMPT | Report   : List of SQL id whose plan changed since last &num_days days and  Best Plan can 
PROMPT |  	    improve more than 50% Execution Time compare to Latest plan			
PROMPT | DB_Name  : &db_unique_name          						
PROMPT | Timestamp: &current_timestamp         					
PROMPT +------------------------------------------------------------------------------------------------+

set sqlblanklines on
set lines 800 
set pages 100
col elapsed_per_exec_thisplan for 999.99 heading 'This Plan|AVG_ETIME'
col elapsed_per_exec_diff     for 999.99 heading 'Diff Plan|AVG_ETIME'
col elapsed_per_exec_diff_pct for 990.90 heading 'Diff Plan|Improve %'
col plan_hash_value for 9999999999 heading 'Plan|Hash Value'
col snap_count for 999 heading 'Snap|Cnt'
--col total_execs for 999999 heading 'Total|Exec'
col XPLAN for a100 heading 'Get Execution Plan Qry'
break on sql_id skip 1
 

/* statements captured during last  days */
with samples as 
 (select *
  from dba_hist_sqlstat st
  join dba_hist_snapshot sn
  using (snap_id, instance_number) 
  where 
  --  sql_id='sqlid'
-- parsing_schema_name = 'schema'
  --and module  'DBMS_SCHEDULER' -- no sql tuning task
   begin_interval_time between sysdate - '&num_days' and sysdate
  and executions_delta > 0),
 

/* just statements that had at least 2 different plans during that time */
  sql_ids as 
   (select sql_id,
    count(distinct plan_hash_value) plancount
    from samples
    group by sql_id
    having count(distinct plan_hash_value) > 2),

/* per combination of sql_id and plan_hash_value, elapsed times per execution */
    plan_stats as 
     (select sql_id,
      plan_hash_value,
      min(parsing_schema_name),
      count(snap_id) snap_count,
      max(end_interval_time) last_seen,
      min(begin_interval_time) first_seen,
      sum(executions_delta) total_execs,
      sum(elapsed_time_delta) / sum(executions_delta) elapsed_per_exec_thisplan
      from sql_ids
      join samples
      using (sql_id)
      group by sql_id, plan_hash_value),

/* how much different is the elapsed time most recently encountered from other elapsed times in the measurement interval? */
      elapsed_time_diffs as 
       (select p.*,
        elapsed_per_exec_thisplan - first_value(elapsed_per_exec_thisplan)
          over(partition by sql_id order by last_seen desc) elapsed_per_exec_diff,
        (elapsed_per_exec_thisplan - first_value(elapsed_per_exec_thisplan)
          over(partition by sql_id order by last_seen desc)) / elapsed_per_exec_thisplan elapsed_per_exec_diff_ratio
        from plan_stats p),

/* consider just statements for which the difference is bigger than our configured threshold */
        impacted_sql_ids as 
         (select *
          from elapsed_time_diffs ),

/* for those statements, get all required information */
          all_info as
           (select sql_id,
            plan_hash_value,
        --    parsing_schema_name,
            snap_count,
            last_seen,
			first_seen,
			total_execs,
            round(elapsed_per_exec_thisplan / 1e6, 2) elapsed_per_exec_thisplan,
            round(elapsed_per_exec_diff / 1e6, 2) elapsed_per_exec_diff,
            round(100 * elapsed_per_exec_diff_ratio, 2) elapsed_per_exec_diff_pct,
            round(max(abs(elapsed_per_exec_diff_ratio))
              over(partition by sql_id), 2) * 100 max_abs_diff,
            round(max(elapsed_per_exec_diff_ratio) over(partition by sql_id), 2) * 100 max_diff,
            'select * from table(dbms_xplan.display_awr(sql_id=>''' || sql_id ||
            ''', plan_hash_value=>' || plan_hash_value || '));' xplan
            from elapsed_time_diffs
            where sql_id in (select sql_id from impacted_sql_ids))

/* format the output */
            select 
             a.sql_id,
				plan_hash_value,
            -- parsing_schema_name,
             a.snap_count,
			total_execs,
		     to_char(a.elapsed_per_exec_thisplan, '999999.99') elapsed_per_exec_thisplan,
             to_char(a.elapsed_per_exec_diff, '999999.99') elapsed_per_exec_diff,
             to_char(a.elapsed_per_exec_diff_pct, '999999.99') elapsed_per_exec_diff_pct,
			to_char(first_seen, 'dd-mon-yy hh24:mi') first_seen,
			 to_char(last_seen, 'dd-mon-yy hh24:mi') last_seen
             --xplan
             from all_info a where sql_id in (select distinct sql_id from all_info where elapsed_per_exec_diff_pct < -50)
             order by sql_id, elapsed_per_exec_diff_pct;