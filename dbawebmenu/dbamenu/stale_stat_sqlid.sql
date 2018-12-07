
set markup html on
define sqlid='&1'
SET TERMOUT OFF;
COLUMN current_instance NEW_VALUE current_instance NOPRINT;
COLUMN db_unique_name NEW_VALUE db_unique_name NOPRINT;
COLUMN current_timestamp NEW_VALUE current_timestamp  NOPRINT;
SELECT rpad(sys_context('USERENV', 'DB_UNIQUE_NAME'),15)  db_unique_name  FROM DUAL;
SELECT rpad(instance_name, 17) current_instance,rpad(to_char(current_timestamp,'DD-MON-YY HH24:MI'),17) current_timestamp FROM v$instance;
SET TERMOUT ON

PROMPT
PROMPT +----------------------------------------------------------+
PROMPT   Report   : Stale stats for sqlid: &sqlid    
PROMPT   DB_Name  : &db_unique_name 
PROMPT   Timestamp: &current_timestamp
PROMPT +----------------------------------------------------------+

--set term off
set pagesize 2000
set long 20000


set heading on
set verify off
set feedback off


col table_owner for a15
col table_name for a30
col partition_name for a30
select distinct b.table_owner, b.table_name, b.partition_name, b.inserts, b.updates, b.deletes, b.TRUNCATED,c.STALE_STATS,
to_char(b.timestamp, 'mm/dd/yyyy hh24:mi') timestamp, to_char(c.last_analyzed, 'mm/dd/yyyy hh24:mi') last_analyzed,
c.num_rows
from (select distinct sql_id, object#, object_name, object_owner from gv$sql_plan where sql_id = '&&sqlid' UNION select distinct sql_id, object#, object_name, object_owner from dba_hist_sql_plan where sql_id = '&&sqlid') a
, sys.dba_tab_modifications b, dba_tab_statistics c
where a.sql_id = '&&sqlid'
and  a.OBJECT_OWNER = b.table_owner
and  a.OBJECT_NAME = b.table_name
and  b.table_owner = c.owner
and  b.table_name  = c.table_name
and  NVL(b.partition_name,'NONE') = NVL(c.partition_name,'NONE')
and b.table_name is not null
order by b.table_owner, b.table_name, b.partition_name;