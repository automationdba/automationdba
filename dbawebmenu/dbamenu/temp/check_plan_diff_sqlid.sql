
set markup html on
SET TERMOUT OFF
COLUMN current_instance NEW_VALUE current_instance NOPRINT;
COLUMN db_unique_name NEW_VALUE db_unique_name NOPRINT;
COLUMN current_timestamp NEW_VALUE current_timestamp  NOPRINT;
SELECT rpad(sys_context('USERENV', 'DB_UNIQUE_NAME'),15)  db_unique_name  FROM DUAL;
SELECT rpad(instance_name, 17) current_instance,to_char(current_timestamp,'MON DD,YYYY HH24:MI:SS') current_timestamp FROM v$instance;
SET TERMOUT ON
PROMPT
PROMPT +------------------------------------------------------------------------+
PROMPT | Report   : Identify Query running with Good or Bad Plan                |
PROMPT | DB_Name  : &db_unique_name                                             |
PROMPT | Timestamp: &current_timestamp                                          |
PROMPT +------------------------------------------------------------------------+


define sqlid=&1
COLUMN sqlid NEW_VALUE sqlid NOPRINT;

PROMPT +-----------------------------------------------+
PROMPT | sqlid &&sqlid Query Current Active plans 
PROMPT +-----------------------------------------------+

set linesize 200
set pagesize 40
col sql_plan_hash_value for 9999999999 heading 'Sql|Plan Hash'
col rows_processed for 999999999 heading 'Rows|Processed'
col SORTS for 9999999

set verify off
col last_load for a19
col plan_hash_value for 9999999999 heading "Plan|Hash Value"
select plan_hash_value,to_char(LAST_LOAD_TIME,'DD-MON-YY HH24:MI:SS') last_load,SORTS,FETCHES,EXECUTIONS,PARSE_CALLS,DISK_READS,DIRECT_WRITES,BUFFER_GETS,ROWS_PROCESSED,HASH_VALUE,OBJECT_STATUS from gv$sqlarea where SQL_ID = '&&sqlid';

PROMPT +---------------------------------------+
PROMPT | &&sqlid Query Last 5 plan history    
PROMPT +---------------------------------------+

set lines 200
set pagesize 200
col snap_id for 999999
col instance_number for 9999
col execs for 999,999,999
col avg_etime for 999,999.999
col avg_lio for 999,999,999
col SQL_PROFILE for a32
col begin_interval_time for a26
col node for 99999
--define sqlid=&1
set verify off
select * from (select ss.snap_id, ss.instance_number node, to_char(begin_interval_time,'DD-MON-YY HH24:MI:SS') Begin_Interval, sql_id, plan_hash_value,
nvl(executions_delta,0) execs,
(elapsed_time_delta/decode(nvl(executions_delta,0),0,1,executions_delta))/1000000 avg_etime,
(buffer_gets_delta/decode(nvl(buffer_gets_delta,0),0,1,executions_delta)) avg_lio,SQL_PROFILE
from DBA_HIST_SQLSTAT S, DBA_HIST_SNAPSHOT SS
where sql_id ='&&sqlid'
and ss.snap_id = S.snap_id
and ss.instance_number = S.instance_number
and executions_delta > 0
--and begin_interval_time > sysdate-1/24
order by begin_interval_time desc,1, 2)
where rownum <= 5
/

PROMPT +---------------------------------------+
PROMPT | &&sqlid Avg Exec Plan History
PROMPT +---------------------------------------+

set lines 200 pages 200
col execs for 999,999,999
col etime for 999,999,999 heading 'Exec_Time(sec)'
col avg_etime for 999,990.999 heading 'Avg |Exec_Time(sec)'
col avg_cpu_time for 999,999.999
col avg_lio for 999,999,999 heading 'Avg | Logical IO'
col avg_pio for 9,999,999  heading 'Avg | Physical IO'
col begin_interval_time for a30
col node for 99999
select sql_id, plan_hash_value,
sum(execs) execs,
sum(etime) etime,
sum(etime)/sum(execs) avg_etime,
sum(cpu_time)/sum(execs) avg_cpu_time,
sum(lio)/sum(execs) avg_lio,
sum(pio)/sum(execs) avg_pio
from (
select ss.snap_id, ss.instance_number node, begin_interval_time, sql_id, plan_hash_value,
nvl(executions_delta,0) execs,
elapsed_time_delta/1000000 etime,
(elapsed_time_delta/decode(nvl(executions_delta,0),0,1,executions_delta))/1000000 avg_etime,
buffer_gets_delta lio,
disk_reads_delta pio,
cpu_time_delta/1000000 cpu_time,
(buffer_gets_delta/decode(nvl(buffer_gets_delta,0),0,1,executions_delta)) avg_lio,
(cpu_time_delta/decode(nvl(executions_delta,0),0,1,executions_delta)) avg_cpu_time
from DBA_HIST_SQLSTAT S, DBA_HIST_SNAPSHOT SS
where sql_id =  '&&sqlid'
and ss.snap_id = S.snap_id
and ss.instance_number = S.instance_number
and executions_delta > 0
)
group by sql_id, plan_hash_value
order by 5
/