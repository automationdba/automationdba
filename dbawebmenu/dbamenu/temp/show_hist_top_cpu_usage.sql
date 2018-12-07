set markup html on
SET TERMOUT OFF;
COLUMN current_instance NEW_VALUE current_instance NOPRINT;
COLUMN db_unique_name NEW_VALUE db_unique_name NOPRINT;
COLUMN current_timestamp NEW_VALUE current_timestamp  NOPRINT;
SELECT rpad(sys_context('USERENV', 'DB_UNIQUE_NAME'),15)  db_unique_name  FROM DUAL;
SELECT rpad(instance_name, 17) current_instance,rpad(to_char(current_timestamp,'DD-MON-YY HH24:MI'),17) current_timestamp FROM v$instance;
SET TERMOUT ON
SET VERIFY      OFF

set linesize 160
set pagesize 40
--clear columns
--clear breaks
define start_time='&1'
define end_time='&2'
ttitle off


PROMPT
PROMPT +---------------------------------------------------------------------+
PROMPT   Report   : History session  of Top 5 CPU Utilized Query
PROMPT   Duration : Between &start_time and &end_time 
PROMPT   DB_Name  : &db_unique_name
PROMPT   Timestamp: &current_timestamp
PROMPT +---------------------------------------------------------------------+




column usr                 format a11       Heading 'User'
column INSTANCE_NUMBER     format 9      heading 'I|N|S'
column SESSION_ID          format 9999      heading 'S|I|D'
column SQL_PLAN_HASH_VALUE format A10       heading 'SQL PLAN|HASH_VALUE'
column stat                format A1        heading 'S|t|a|t'
column serial              format 9999999   heading 'Serial#'
column machine             format A24       heading 'Machine'
column program             format A16       heading 'Program'
column physical_reads      format 999999999 heading 'Physical|Reads'
column chgs                format A9        heading 'Logical|  Chgs'
column Block_sess          format A6 heading 'Blk|sess'
column module              format A16       heading 'Module'
column Obj_name            format A16       heading 'Obj|Name'
column wait_class           format A10       heading 'Wait Class'
column Time_Waited          format A10       heading 'Time|Waited'
column instance            format A13       heading 'Inst:|Sid,Serial#'
column sql_id              format A13       heading 'SQL ID'
select * from (
select 
	SQL_ID, 
	sum(CPU_TIME_DELTA), 
	sum(DISK_READS_DELTA),
	count(*)
from 
	DBA_HIST_SQLSTAT a, dba_hist_snapshot s
where
 s.snap_id = a.snap_id
 and s.begin_interval_time  >= to_timestamp('&start_time', 'YYYY-MM-DD HH24:MI')
  and s.end_interval_time   <= to_timestamp('&end_time', 'YYYY-MM-DD HH24:MI')
	group by 
	SQL_ID
order by 
	sum(CPU_TIME_DELTA) desc)
where rownum < 6
/