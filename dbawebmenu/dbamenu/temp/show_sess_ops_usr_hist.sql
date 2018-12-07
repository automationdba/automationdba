set markup html on
SET TERMOUT OFF;
COLUMN current_instance NEW_VALUE current_instance NOPRINT;
COLUMN db_unique_name NEW_VALUE db_unique_name NOPRINT;
COLUMN current_timestamp NEW_VALUE current_timestamp  NOPRINT;
SELECT rpad(sys_context('USERENV', 'DB_UNIQUE_NAME'),15)  db_unique_name  FROM DUAL;
SELECT rpad(instance_name, 17) current_instance,rpad(to_char(current_timestamp,'DD-MON-YY HH24:MI'),17) current_timestamp FROM v$instance;
SET TERMOUT ON

PROMPT
PROMPT +---------------------------------------------------------------------------+
PROMPT   Report   : Session History Details(from &2 to &3)
PROMPT   DB_Name  : &db_unique_name
PROMPT   Timestamp: &current_timestamp
PROMPT +---------------------------------------------------------------------------+


------------------------------------------------
-- Show Active/Inactive Sessions for Only Users
---------------------------------------------
set linesize 180
set pagesize 40
--clear columns
--clear breaks
define input=&1
define start_time=&2
define end_time=&3
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
column Obj_name            format A22       heading 'Obj|Name'
column wait_class           format A10       heading 'Wait Class'
column Time_Waited          format A10       heading 'Time|Waited|Sec'
column instance            format A12       heading 'Inst:|Sid,Serial#'
column sql_id              format A13       heading 'SQL ID'
-- column SQL_CHILD_NUMBER  format   9999999       heading 'SQL Child'
column SESSION_STATE     format A9       heading 'Sess Stat'
column events      format A19       heading 'Sess Event'
set verify off
SELECT s.INSTANCE_NUMBER||':'||S.SESSION_ID||','||S.SESSION_SERIAL# instance, rpad(U.USERNAME,11) Usr,
       TO_CHAR(S.SAMPLE_TIME,'YYYY-MM-DD HH24:MI') sample_time,
       to_char(s.SQL_PLAN_HASH_VALUE) SQL_PLAN_HASH_VALUE,S.SQL_ID,OBJECT_NAME Obj_name,
 substr(s.program,instr(s.program,'@')+1,
              instr(s.program,' ')-instr(s.program,'@')) machine
     ,substr(S.WAIT_CLASS,1,10) wait_class
     ,substr(round(S.TIME_WAITED/1000000),1,10) Time_Waited
	,SESSION_STATE 
	,substr(event,1,19) events
     ,to_char(BLOCKING_INST_ID)||':'||to_char(BLOCKING_SESSION) Block_sess
  FROM
       DBA_HIST_ACTIVE_SESS_HISTORY S,
       DBA_USERS  U
	   ,dba_objects o
 WHERE
       S.USER_ID = U.USER_ID
       AND S.USER_ID != 0
	   and o.OBJECT_ID=s.CURRENT_OBJ# 
  and  s.sample_time >= to_timestamp('&&start_time', 'YYYY-MM-DD HH24:MI')
  and s.sample_time <= to_timestamp('&&end_time', 'YYYY-MM-DD HH24:MI')
   and ((to_char(s.SESSION_ID)='&input') or (upper(S.SQL_PLAN_HASH_VALUE) like upper('%&input%')) or (upper(U.USERNAME) like upper('%&input%')) or (upper(S.sql_id) like upper ('&&input%')) or (upper(o.object_name) like upper('%&input%')))
 ORDER BY sample_time,1,4,3;
PROMPT +------------------------------------------------------------------------+
PROMPT +-----------Objects involved during execution of query-------------------+
col obj_name for a40
col obj_type for a40
col owner for a25
col is_temp_table for a14 heading 'IS_TEMP|Table'
SELECT distinct OWNER owner,OBJECT_NAME obj_name,OBJECT_TYPE obj_type,temporary is_temp_table
   FROM
       DBA_HIST_ACTIVE_SESS_HISTORY S,
       DBA_USERS  U
           ,dba_objects o
 WHERE
       S.USER_ID = U.USER_ID
       AND S.USER_ID != 0
           and o.OBJECT_ID=s.CURRENT_OBJ#
  and  s.sample_time >= to_timestamp('&&start_time', 'YYYY-MM-DD HH24:MI')
  and s.sample_time <= to_timestamp('&&end_time', 'YYYY-MM-DD HH24:MI')
   and ((to_char(s.SESSION_ID)='&input') or (upper(S.SQL_PLAN_HASH_VALUE) like upper('%&input%')) or (upper(U.USERNAME) like upper('%&input%')) or (upper(S.sql_id) like upper ('&&input%')) or (upper(o.object_name) like upper('%&input%')))
/