set markup html on
define sqlid=&1
SET TERMOUT OFF;
COLUMN current_instance NEW_VALUE current_instance NOPRINT;
COLUMN db_unique_name NEW_VALUE db_unique_name NOPRINT;
COLUMN current_timestamp NEW_VALUE current_timestamp  NOPRINT;
SELECT rpad(sys_context('USERENV', 'DB_UNIQUE_NAME'),15)  db_unique_name  FROM DUAL;
SELECT rpad(instance_name, 17) current_instance,rpad(current_timestamp,22) current_timestamp FROM v$instance;
SET TERMOUT ON

PROMPT
PROMPT +------------------------------------------------------------------------+
PROMPT | Report   : Query plan History for sqlid &1                                   |
PROMPT | DB_Name  : &db_unique_name                                             |
PROMPT | Timestamp: &current_timestamp                                          |
PROMPT +------------------------------------------------------------------------+


set lines 200
set pagesize 200
col execs for 999,999,999
col avg_etime for 999,999.999 heading avg_exec|time(s)
col avg_lio for 999,999,999.9
col begin_interval_time for a30
col node for 99999
col SQL_PROFILE for a45

set verify off
col PLAN_HASH_VALUE for 9999999999 heading 'Plan Hash'
col PARSING_SCHEMA_NAME for a10 heading 'Parsing Schema'
col END_INTERVAL_TIME for a30

SELECT STAT.SNAP_ID,STAT.SQL_ID, PLAN_HASH_VALUE, PARSING_SCHEMA_NAME, round(ELAPSED_TIME_DELTA/1000000,2) exec_sec, SS.END_INTERVAL_TIME,SQL_PROFILE FROM DBA_HIST_SQLSTAT STAT, DBA_HIST_SQLTEXT TXT, DBA_HIST_SNAPSHOT SS WHERE STAT.SQL_ID = TXT.SQL_ID AND STAT.DBID = TXT.DBID AND SS.DBID = STAT.DBID AND SS.INSTANCE_NUMBER = STAT.INSTANCE_NUMBER AND STAT.SNAP_ID = SS.SNAP_ID AND  STAT.INSTANCE_NUMBER = 1 AND SS.BEGIN_INTERVAL_TIME >= sysdate-7 AND UPPER(STAT.SQL_ID) =  upper('&sqlid') ORDER BY stat.snap_id desc
/

select ss.snap_id, ss.instance_number node, begin_interval_time, sql_id, plan_hash_value,
nvl(executions_delta,0) execs,
(elapsed_time_delta/decode(nvl(executions_delta,0),0,1,executions_delta))/1000000 avg_etime,
(buffer_gets_delta/decode(nvl(buffer_gets_delta,0),0,1,executions_delta)) avg_lio,SQL_PROFILE
from DBA_HIST_SQLSTAT S, DBA_HIST_SNAPSHOT SS
where upper(sql_id) like upper('&&sqlid')
and ss.snap_id = S.snap_id
and ss.instance_number = S.instance_number
and executions_delta > 0
order by 1,2,begin_interval_time 
/
PROMPT +-------------------------------------------------+
PROMPT | Execution times of the various plans in history |
PROMPT +-------------------------------------------------+

set lines 200 pages 200
col execs for 999,999,999

col etime for 999,999,999.9
col avg_etime for 999,999.999
col avg_cpu_time for 999,999.999
col avg_lio for 999,999,999.9
col avg_pio for 9,999,999.9
col begin_interval_time for a30
col node for 99999
--break on plan_hash_value on startup_time skip 1
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