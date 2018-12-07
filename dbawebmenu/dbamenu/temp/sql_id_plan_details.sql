
set markup html on
SET TERMOUT OFF;
COLUMN current_instance NEW_VALUE current_instance NOPRINT;
SELECT rpad(sys_context('USERENV', 'INSTANCE_NAME'), 17) current_instance FROM dual;
SET TERMOUT ON;
define sql_id=&1
--COLUMN sql_id  NEW_VALUE sql_id NOPRINT;

PROMPT
PROMPT +------------------------------------------------------------------------+
PROMPT | Report   : SQL Details for sql_id:&sql_id                               |
PROMPT | Instance : &current_instance                                           |
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
COLUMN total_gb               FORMAT 999,999,999   HEAD 'Total Size (GB)'
COLUMN used_gb                FORMAT 999,999,999   HEAD 'Used Size (GB)'
COLUMN free_gb                FORMAT 999,999,999   HEAD 'Free Size (GB)'
COLUMN pct_used               FORMAT 999.99        HEAD 'Pct. Used'


select sql_id, invalidations, loads from v$sql where sql_id like '&sql_id';

PROMPT
PROMPT +------------------------------------------------+
PROMPT | Check Progress  for sql Id : &sql_id           | 
PROMPT +------------------------------------------------+
PROMPT
select SORTS
,FETCHES
,EXECUTIONS
,PARSE_CALLS
,DISK_READS
,DIRECT_WRITES
,BUFFER_GETS
,ROWS_PROCESSED
,ADDRESS
,HASH_VALUE
,OBJECT_STATUS from gv$sqlarea
where SQL_ID = '&sql_id';

PROMPT  ALL EXISTING PLAN for same SQL_ID: &sql_id
PROMPT

select distinct * from (select plan_hash_value, to_char(timestamp, 'dd-MON-yyyy hh24:mi:ss') timestamp 
from dba_hist_sql_plan where sql_id = '&sql_id'
union all
select plan_hash_value, to_char(timestamp, 'dd-MON-yyyy hh24:mi:ss') timestamp 
from gv$sql_plan where sql_id = '&sql_id')
order by timestamp desc;

set linesize 2000
set echo on
set pagesize 200
col table_owner for a15
col table_name for a25
col partition_name  for a25
col num_rows for 99999999
col b.partition_name for a15
select distinct b.table_owner, b.table_name, b.partition_name, b.inserts, b.updates, b.deletes, b.TRUNCATED,c.STALE_STATS,
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

PROMPT -------------
PROMPT  SQL PLAN 
PROMPT -------------
select SQL_HANDLE, PLAN_NAME,ENABLED,ACCEPTED,AUTOPURGE,creator,to_char(created,'dd-MON-yyyy hh24:mi') create_dt from dba_sql_plan_baselines;
SELECT t.*
FROM gv$sql s, table(DBMS_XPLAN.DISPLAY_CURSOR(s.sql_id, s.child_number)) t
WHERE s.sql_id='&sql_id';