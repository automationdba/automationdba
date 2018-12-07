
set markup html on
REM   Show Query execution history with total run time 
SET TERMOUT OFF;
COLUMN current_instance NEW_VALUE current_instance NOPRINT;
COLUMN db_unique_name NEW_VALUE db_unique_name NOPRINT;
COLUMN current_timestamp NEW_VALUE current_timestamp  NOPRINT;
SELECT rpad(sys_context('USERENV', 'DB_UNIQUE_NAME'),15)  db_unique_name  FROM DUAL;
SELECT rpad(instance_name, 17) current_instance,rpad(to_char(current_timestamp,'DD-MON-YY HH24:MI'),17) current_timestamp FROM v$instance;
SET TERMOUT ON

define input='&1'
define start_time='&2'
define end_time='&3' 

PROMPT
PROMPT +--------------------------------------------------------------------------------------+
PROMPT   Report   : Execution History of sql_id &1 
PROMPT   Duration : Between &start_time and &end_time 
PROMPT   DB_Name  : &db_unique_name
PROMPT   Timestamp: &current_timestamp
PROMPT +--------------------------------------------------------------------------------------+


------------------------------------------------
-- Show Active/Inactive Sessions for Only Users
---------------------------------------------
set linesize 180
set pagesize 40
--clear columns
--clear breaks

ttitle off

column usr                 format a11       Heading 'User'
column INSTANCE_NUMBER     format 9      heading 'I|N|S'
column SESSION_ID          format 9999      heading 'S|I|D'
column SQL_PLAN_HASH_VALUE format A10       heading 'SQL PLAN|HASH_VALUE'
column stat                format A1        heading 'S|t|a|t'
column serial              format 9999999   heading 'Serial#'
column machine             format A18       heading 'Machine'
column program             format A16       heading 'Program'
column physical_reads      format 999999999 heading 'Physical|Reads'
column chgs                format A9        heading 'Logical|  Chgs'
column Block_sess          format A6 heading 'Blk|sess'
column module              format A16       heading 'Module'
column Obj_name            format A24       heading 'Obj|Name'
column wait_class           format A10       heading 'Wait Class'
column Time_Waited          format A8       heading 'Time|Waited'
column instance            format A12       heading 'Inst:|Sid,Serial#'
column sql_id              format A13       heading 'SQL ID'
-- column SQL_CHILD_NUMBER  format   9999999       heading 'SQL Child'
column SESSION_STATE     format A9       heading 'Sess Stat'
column wait_events      format A19       heading 'Sess Event'
set verify off

col total_time format a25 heading 'Total Exec Time'
col start_time for a18 heading 'Query Start Time'
col end_time for a18 heading 'Query End Time'
select s.sql_id,s.SQL_EXEC_ID,to_char(MIN(S.SQL_EXEC_START),'DD-MON-YYYY:HH24:MI') start_time,
	to_char(MAX(S.SAMPLE_TIME),'DD-MON-YYYY:HH24:MI') end_time, 
  --	to_char(MAX(S.SAMPLE_TIME)-MIN(S.SQL_EXEC_START),'HH24:MI:SS') total_time 
	to_char((MAX(S.SAMPLE_TIME) -MIN(S.SQL_EXEC_START)),'HH24:MI')/1000000  total_sec 
FROM DBA_HIST_ACTIVE_SESS_HISTORY S
WHERE s.sample_time >= to_timestamp('&start_time', 'YYYY-MM-DD HH24:MI')
  and s.sample_time <= to_timestamp('&end_time', 'YYYY-MM-DD HH24:MI')
  and s.sql_id = '&input'
group by s.sql_id,SQL_EXEC_ID
order by 1,2
/