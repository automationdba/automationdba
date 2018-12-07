
set markup html on
undefine input
define input=&1

SET TERMOUT OFF;
COLUMN current_instance NEW_VALUE current_instance NOPRINT;
COLUMN db_unique_name NEW_VALUE db_unique_name NOPRINT;
COLUMN current_timestamp NEW_VALUE current_timestamp  NOPRINT;
SELECT rpad(sys_context('USERENV', 'DB_UNIQUE_NAME'),15)  db_unique_name  FROM DUAL;
SELECT rpad(instance_name, 17) current_instance,rpad(to_char(current_timestamp,'DD-MON-YY HH24:MI'),17) current_timestamp FROM v$instance;
SET TERMOUT ON

PROMPT
PROMPT +----------------------------------------+
PROMPT   Report   : Get session detail  
PROMPT   DB_Name  : &db_unique_name 
PROMPT   Timestamp: &current_timestamp
PROMPT +----------------------------------------+



------------------------------------------------
-- Show Active/Inactive Sessions for Only Users
---------------------------------------------
set linesize 180
set pagesize 60
--clear columns
--clear breaks

ttitle off

column usr                 format a21       Heading 'Osuser  /User'
column sid                 format 9999      heading 'S|I|D'
column connected           format A16       heading 'Connected'
column stat                format A1        heading 'S|t|a|t'
column serial              format 9999999   heading 'Serial#'
column machine             format A20       heading 'Machine'
column logical             format A19       heading '      Logical|    Gets / Chgs'
column physical_reads      format 9999999 heading 'Physical|Reads'
column SECONDS_IN_WAIT     format 9999999 heading 'WAIT|Seconds'
column chgs                format A9        heading 'Logical|  Chgs'
column consistent_changes  format 999999999 heading 'Consist|Changes'
column module              format A12       heading 'Module'
column instance            format A13       heading 'Inst:|Sid,Serial#'
column sql_id              format A13       heading 'SQL ID'
column sess_event          format A16       heading 'Sess|Event'
column Command_Type        format A10       heading 'SQL|Type'
col state for a12
col SQL_Type for A9
set verify off
SELECT s.inst_id||':'||S.SID||','||S.SERIAL# instance, rpad(S.OSUSER,8)||'/'||rpad(S.USERNAME,12) Usr,
       substr(S.STATUS,1,1) STAT,
       TO_CHAR(S.LOGON_TIME,'YYYY-MM-DD HH24:MI') connected,
       substr(S.MACHINE,1,20) MACHINE,
       substr(S.MODULE,1,24) module,
	substr(AA.NAME,1,15) Command_Type,
	s.sql_id,
	S.state,
	SECONDS_IN_WAIT,
	substr(s.event,1,30) sess_event
  FROM
       GV$SESSION S,
	AUDIT_ACTIONS AA
 WHERE
    S.USER# != 0
   and S.command=AA.ACTION
   and ((to_char(s.sid)='&input') or (upper(S.OSUSER) like upper('%&input%')) or (upper(S.USERNAME) like upper('%&input%')) or (upper(S.sql_id) like upper ('&&input%')) or (upper(s.module) like upper('%&input%'))) 
 ORDER BY 1,4,3;
PROMPT
PROMPT Additional details
PROMPT +----------------+

col actions for a25
col sql_text for a40
col CLIENT_INFO for a15
col ACTION for a15
col plsql_object for a30 heading 'Plsql Object Details'
col plsql_entry_subprogram for a15 heading 'Plsql entry|Subprogram'
col OBJECT for a15 heading 'Row wait|Object'
col BLOCKING_SESSION_STATUS for a11 heading 'Blockng|Sess Stat'
col SQL_HASH_VALUE for 9999999999 heading 'SQL|HASH VALUE'
SELECT s.inst_id||':'||S.SID||','||S.SERIAL# instance
,( SELECT substr(object_name,1,12)    FROM dba_procedures WHERE object_id = plsql_entry_object_id AND subprogram_id = 0) ||'/'|| 
( SELECT substr(procedure_name,1,12) FROM dba_procedures WHERE object_id = plsql_entry_object_id AND subprogram_id = plsql_entry_subprogram_id)||'/'|| 
( SELECT substr(object_name,1,12)    FROM dba_procedures WHERE object_id = plsql_object_id       AND subprogram_id = 0) AS plsql_object
--rpad(S.OSUSER,8)||'/'||rpad(S.USERNAME,10) Usr_detail, substr(S.STATUS,1,1) STAT, S.SQL_ID,
,S.PREV_SQL_ID previous_sql
,TO_CHAR(S.SQL_EXEC_START,'YYYY-MM-DD HH24:MI') SQL_EXEC_START
,round(TIME_REMAINING_MICRO/1000000,1) Sec_Remain
--       lpad(to_char(I.BLOCK_GETS+I.CONSISTENT_GETS),9)||'/'|| lpad(to_char(I.BLOCK_CHANGES+I.CONSISTENT_CHANGES),9) logical
--       I.PHYSICAL_READS
,S.SQL_HASH_VALUE,S.CLIENT_INFO,S.ACTION,substr(O.object_name,1,30) Object
,BLOCKING_SESSION_STATUS 
FROM
       GV$SESSION S, 
       GV$SESS_IO I,
	DBA_OBJECTS O	
 WHERE
       S.SID = I.SID
   AND S.INST_ID = I.INST_ID
   AND S.USER# != 0
  AND o.OBJECT_ID (+)=s.ROW_WAIT_OBJ#
   and ((to_char(s.sid)='&input') or (upper(S.OSUSER) like upper('%&input%')) or (upper(S.USERNAME) like upper('%&input%')) or (upper(S.sql_id) like upper ('&&input%')))
 ORDER BY 1,2;
   --  S.INST_ID = A.INST_ID
   -- AND S.SQL_ID = A.SQL_ID
  --  AND S.SQL_ADDRESS    = A.ADDRESS
  --  AND S.SQL_HASH_VALUE = A.HASH_VALUE