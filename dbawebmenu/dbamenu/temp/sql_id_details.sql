
set markup html on
SET TERMOUT OFF;
COLUMN current_instance NEW_VALUE current_instance NOPRINT;
COLUMN db_unique_name NEW_VALUE db_unique_name NOPRINT;
COLUMN current_timestamp NEW_VALUE current_timestamp  NOPRINT;
SELECT rpad(sys_context('USERENV', 'DB_UNIQUE_NAME'),15)  db_unique_name  FROM DUAL;
SELECT rpad(instance_name, 17) current_instance,rpad(to_char(current_timestamp,'DD-MON-YY HH24:MI'),17) current_timestamp FROM v$instance;
SET TERMOUT ON

define sql_id=&1
--COLUMN sql_id  NEW_VALUE sql_id NOPRINT;

PROMPT +------------------------------------------------------------------------+
PROMPT   Report   : SQL Details for sql_id:&sql_id
PROMPT   Instance : &current_instance
PROMPT   Timestamp: &current_timestamp
PROMPT +------------------------------------------------------------------------+

SET ECHO        OFF
SET FEEDBACK    6
SET HEADING     ON
SET LINESIZE    180
SET PAGESIZE    50000
SET TERMOUT     ON
SET TIMING      OFF
SET TRIMOUT     ON
SET TRIMSPOOL   ON
SET VERIFY      OFF

CLEAR COLUMNS
CLEAR BREAKS
CLEAR COMPUTES

COLUMN group_name             FORMAT a30           HEAD 'Disk Group|Name'
COLUMN sector_size            FORMAT 99,999        HEAD 'Sector|Size'
COLUMN block_size             FORMAT 99,999        HEAD 'Block|Size'
--COLUMN allocation_unit_size   FORMAT 999,999,999   HEAD 'Allocation|Unit Size'
COLUMN state                  FORMAT a11           HEAD 'State'
COLUMN type                   FORMAT a6            HEAD 'Type'
COLUMN remote                 FORMAT a1            HEAD 'R|E|M|O|T|E'
COLUMN plan_hash_value        FORMAT 9999999999    HEAD 'Plan|Hash Value'
COLUMN invalidations          FORMAT 999999        HEAD 'Invalid'
COLUMN elapsed_time           FORMAT 99999999999   HEAD 'elapsed|time'
COLUMN total_gb               FORMAT 999,999,999   HEAD 'Total Size (GB)'
COLUMN used_gb                FORMAT 999,999,999   HEAD 'Used Size (GB)'
COLUMN free_gb                FORMAT 999,999,999   HEAD 'Free Size (GB)'
COLUMN pct_used               FORMAT 999.99        HEAD 'Pct. Used'

--select sql_id, invalidations, loads from v$sql where lower(sql_id)like lower(rtrim(ltrim(('&sql_id'))));
--select PLAN_HASH_VALUE,SQL_ID, OBJECT_STATUS,ROWS_PROCESSED from gv$sqlarea where sql_id='&sql_id';
PROMPT SQL CURR PLAN
set term on feed on echo on 
select sql_id ,plan_hash_value,hash_value,old_hash_value, executions,rows_processed,loads,invalidations,elapsed_time,remote, parse_calls
from gv$sqlarea where sql_id='&sql_id';

set term off
PROMPT  SQL HIST PLAN

select distinct plan_hash_value, to_char(timestamp, 'dd-MON-yyyy hh24:mi:ss') timestamp 
from dba_hist_sql_plan where sql_id = '&sql_id'
order by timestamp desc;

PROMPT

COLUMN user_io_wait_time      FORMAT 99999999999   HEAD 'user_io|wait_time'
COLUMN sorts      FORMAT 999999   HEAD 'sorts'
select SORTS
,FETCHES
,DISK_READS
,DIRECT_WRITES
,BUFFER_GETS
,USER_IO_WAIT_TIME
,SQL_PLAN_BASELINE
,OBJECT_STATUS from gv$sqlarea
where SQL_ID = '&sql_id';

PROMPT  Query Progress...
--select SQL_HANDLE, PLAN_NAME,ENABLED,ACCEPTED,AUTOPURGE,creator,CREATED from dba_sql_plan_baselines;
set linesize 200
set echo on
set pagesize 2000
col table_owner for a10
col table_name for a30
col num_rows for 99999999
col inserts for 9999999
col updates for 9999999
col deletes for 9999999
col partition_name for a16
col truncated for a3 head 'Trun|cate'
col stale_stats for a4 head 'Stal|stat'
select distinct b.table_owner,b.table_name, b.partition_name, b.inserts, b.updates, b.deletes, b.TRUNCATED,c.STALE_STATS,
to_char(b.timestamp, 'mm/dd/yyyy hh24:mi') timestamp, to_char(c.last_analyzed, 'mm/dd/yyyy hh24:mi') last_analyzed,
c.num_rows
from (select distinct sql_id, object#, object_name, object_owner from v$sql_plan where sql_id = '&&sql_id' UNION select distinct sql_id, object#, object_name, object_owner from dba_hist_sql_plan where sql_id = '&&sql_id') a
, sys.dba_tab_modifications b, dba_tab_statistics c
where a.sql_id = '&sql_id'
and  a.OBJECT_OWNER = b.table_owner
and  a.OBJECT_NAME = b.table_name
and  b.table_owner = c.owner
and  b.table_name  = c.table_name
and  NVL(b.partition_name,'NONE') = NVL(c.partition_name,'NONE')
and b.table_name is not null
order by b.table_owner, b.table_name, b.partition_name;
exit