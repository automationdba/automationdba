set markup html on
SET TERMOUT OFF;
COLUMN current_instance NEW_VALUE current_instance NOPRINT;
COLUMN db_unique_name NEW_VALUE db_unique_name NOPRINT;
COLUMN current_timestamp NEW_VALUE current_timestamp  NOPRINT;
SELECT rpad(sys_context('USERENV', 'DB_UNIQUE_NAME'),15)  db_unique_name  FROM DUAL;
SELECT rpad(instance_name, 17) current_instance,rpad(to_char(current_timestamp,'DD-MON-YY HH24:MI'),17) current_timestamp FROM v$instance;
define userin=&1
 
SET TERMOUT ON

PROMPT
PROMPT +------------------------------------------------------------------------+
PROMPT   Report   	: User  &userin  Last 30 Min Session History Details
PROMPT   DB_Name  	: &db_unique_name
PROMPT   Report Time 	: &current_instance
PROMPT +------------------------------------------------------------------------+


set linesize 200
set pagesize 100
col APP_USER for a20
col AVG_ELAPSED_TIME for 99999 heading 'AVG|ELAPSED TIME'
col plan_hash_value for 99999999999 heading 'PLAN|HASH VALUE'
col MODULE for a30
define parse_schema=&1
set verify off
select
parsing_schema_name as App_user, to_char(begin_interval_time, 'mm/dd/yyyy hh24:mi') as exec_time,
sql_id, plan_hash_value, module, SUM(executions_delta) AS executions ,
ROUND(SUM(elapsed_time_delta) / 1000000 / SUM(executions_delta))    avg_elapsed_time ,
ROUND(ROUND(SUM(buffer_gets_delta)*8192)/1024/1024/1024) LG_IO_GB ,
  round(ROUND(SUM(disk_reads_delta + direct_writes_delta) * 8192, 4)/1024/1024/1024) PH_IO_GB
from dba_hist_sqlstat  dhst, dba_hist_snapshot dhsp
where upper(parsing_schema_name) in upper(('&&userin'))
and plan_hash_value not in (0)
and dhst.snap_id =dhsp.snap_id
and dhsp.end_interval_time > sysdate-1/60
group by
parsing_schema_name
,to_char(begin_interval_time, 'mm/dd/yyyy hh24:mi')
,sql_id
,plan_hash_value
,module
HAVING SUM(executions_delta) > 0
order by sql_id, exec_time
/