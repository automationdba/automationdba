
set markup html on
undefine sql_id
define sql_id=&1

SET TERMOUT OFF;
COLUMN current_instance NEW_VALUE current_instance NOPRINT;
COLUMN db_unique_name NEW_VALUE db_unique_name NOPRINT;
COLUMN current_timestamp NEW_VALUE current_timestamp  NOPRINT;
SELECT rpad(sys_context('USERENV', 'DB_UNIQUE_NAME'),15)  db_unique_name  FROM DUAL;
SELECT rpad(instance_name, 17) current_instance,rpad(to_char(current_timestamp,'DD-MON-YY HH24:MI'),17) current_timestamp FROM v$instance;
SET TERMOUT ON

PROMPT
PROMPT +----------------------------------------+
PROMPT   Report   : Long running session detail  
PROMPT   DB_Name  : &db_unique_name 
PROMPT   Timestamp: &current_timestamp
PROMPT +----------------------------------------+


set verify off
set feed off
col PLAN_HASH_VALUE for 999999999999 heading 'Plan Hash|Value'
column sql_id NEW_VALUE sql_id
select distinct plan_hash_value, to_char(timestamp, 'dd-MON-yyyy hh24:mi ss') timestamp from dba_hist_sql_plan where sql_id = '&sql_id'
order by 2;

set feed on
prompt
prompt RESOURCE UTILIZATION current executing query(only if more than 5 sec cpu or i/o utilized)
prompt
col inst_id format 99 heading 'I|N|S' 
col sid for 9999 
SELECT inst_id,sid,status,buffer_gets, disk_reads, round(cpu_time/1000000,1) cpu_seconds,round(elapsed_time/1000000,1) exe_seconds,round(APPLICATION_WAIT_TIME/1000000,1) appln_wait,px_server# 
FROM gv$sql_monitor
WHERE sql_id='&sql_id' order by  px_server#;
set feed off

PROMPT
PROMPT
PROMPT +------------------------------------------------------------------------+
PROMPT | CURRENT SESSION DETAIL                                                 |
PROMPT +------------------------------------------------------------------------+
column usr                 format a20       Heading 'Osuser/User'
column sid                 format 9999      heading 'S|I|D'
column program             format A29       heading 'program'
column stat                format A1        heading 'S|t|a|t'
column serial              format 999999   heading 'Sr#'
column machine             format A20       heading 'Machine'
column logical             format A19       heading '      Logical|    Gets / Chgs'
column module              format A30       heading 'Module'
column sess_detail         format A14       heading 'Sess_details'

set pagesize 300
col client_identifier for a30
select s.inst_id||':('||s.sid||','||s.serial#||')' sess_detail,s.sql_id,s.machine,s.osuser||' '||s.username usr,s.logon_time,s.program,s.event,s.status,s.client_identifier,s.MODULE 
from gv$session s,gv$process p 
where p.addr=s.paddr and s.sql_id='&sql_id';
--before purge plan check is there any other session with same sql id ***********
--exec sys.dbms_shared_pool.purge ('Address,hash_value','C');

column SORTS format 999999   heading 'Sorts'
column FETCHES format 999999   heading 'Fetches'
column DIRECT_WRITES format 999999   heading 'Drct_Wrts'
select inst_id,sql_id,SORTS,FETCHES,EXECUTIONS,PARSE_CALLS,DISK_READS,DIRECT_WRITES,BUFFER_GETS,ROWS_PROCESSED,ADDRESS,HASH_VALUE,OBJECT_STATUS from gv$sqlarea where SQL_ID = '&sql_id';
PROMPT

--cursor invalidate
--EXEC DBMS_STATS.GATHER_TABLE_STATS(OWNNAME=>'OTS', TABNAME=>'TRN_HOLDINGS',  estimate_percent=>DBMS_STATS.AUTO_SAMPLE_SIZE, degree=>16, method_opt=>'for all columns size repeat');

col parsing_schema_name for a20 heading 'Parsing|Schema|Name'
col AVG_CPU_TIME for 9999999 heading 'avg_cpu|time'
col avg_elapsed_time for  9999999 heading 'avg_elap|time'
col IO_per_day_GB for  9999999 heading 'IO_per_day|GB'
SELECT 
TO_CHAR(s.begin_interval_time, 'mm/dd/yyyy hh24:mi') AS Day,
-- TO_CHAR(s.end_interval_time, 'mm/dd/yyyy hh24:mi') AS interval_end,
--q.snap_id,
parsing_schema_name,
--module,
q.sql_id ,
q.plan_hash_value,
SUM(executions_delta) AS executions ,
ROUND(SUM(cpu_time_delta) / 1000000 / SUM(executions_delta)) avg_cpu_time ,
ROUND(SUM(cpu_time_delta) / 1000000) total_cpu ,
ROUND(SUM(elapsed_time_delta) / 1000000 / SUM(executions_delta)) avg_elapsed_time ,
ROUND(SUM(elapsed_time_delta) / 1000000) total_elap ,
round(ROUND(SUM(disk_reads_delta + direct_writes_delta)*8192/SUM(executions_delta), 4)/1024/1024) avg_io_MB,
round(ROUND(SUM(disk_reads_delta + direct_writes_delta) * 8192, 4)/1024/1024/1024) IO_per_day_GB
FROM dba_hist_sqlstat q, dba_hist_snapshot s
WHERE q.dbid = s.dbid
AND q.snap_id = s.snap_id
--AND s.end_interval_time between TO_DATE('07/10/2012', 'mm/dd/yyyy') and TO_DATE('07/12/2012', 'mm/dd/yyyy')
--AND parsing_schema_name in ('FIAADMIN' )
and s.END_INTERVAL_TIME > sysdate-7
and q.SQL_ID in ('&sql_id')
GROUP BY
TO_CHAR(s.begin_interval_time, 'mm/dd/yyyy hh24:mi')
--, TO_CHAR(s.begin_interval_time, 'mm/dd/yyyy')
,parsing_schema_name 
--, module
--, q.snap_id
, q.sql_id
,q.plan_hash_value
HAVING SUM(executions_delta) > 0
ORDER BY 1,IO_per_day_GB desc;

--
-- SQL_Plan
set long 999999999

SELECT t.*
FROM gv$sql s, table(DBMS_XPLAN.DISPLAY_CURSOR(s.sql_id, s.child_number)) t
WHERE s.sql_id='&sql_id';

PROMPT
PROMPT
PROMPT +------------------------------------------------------------------------+
PROMPT | STALE STATISTICS                                                       |
PROMPT +------------------------------------------------------------------------+
-- STALE STATISTICS
set head on;
set linesize 200
col table_owner for a15
col table_name for a25
col partition_name for a20
select distinct b.table_owner, b.table_name, b.partition_name, b.inserts, b.updates, b.deletes, b.TRUNCATED,c.STALE_STATS,
to_char(b.timestamp, 'mm/dd/yyyy hh24:mi') timestamp, to_char(c.last_analyzed, 'mm/dd/yyyy hh24:mi') last_analyzed,
c.num_rows
from (select distinct sql_id, object#, object_name, object_owner from v$sql_plan where sql_id = '&sql_id' UNION select distinct sql_id, object#, object_name, object_owner from dba_hist_sql_plan where sql_id = '&sql_id') a
, sys.dba_tab_modifications b, dba_tab_statistics c
where a.sql_id = '&sql_id'
and  a.OBJECT_OWNER = b.table_owner
and  a.OBJECT_NAME = b.table_name
and  b.table_owner = c.owner
and  b.table_name  = c.table_name
and  NVL(b.partition_name,'NONE') = NVL(c.partition_name,'NONE')
and b.table_name is not null
order by b.table_owner, b.table_name, b.partition_name;

PROMPT
PROMPT
PROMPT +------------------------------------------------------------------------+
PROMPT | FLUSH PLAN QUERY SYNTAX                                                |
PROMPT +------------------------------------------------------------------------+
select 'exec sys.dbms_shared_pool.purge('''||address||','||hash_value||''',''c'',1);' Flush_Plan_Syntax  from v$sqlarea where sql_id like '&sql_id';
PROMPT