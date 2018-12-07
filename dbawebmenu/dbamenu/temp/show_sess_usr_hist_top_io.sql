
set markup html on
SET TERMOUT OFF;
COLUMN current_instance NEW_VALUE current_instance NOPRINT;
COLUMN db_unique_name NEW_VALUE db_unique_name NOPRINT;
COLUMN current_timestamp NEW_VALUE current_timestamp  NOPRINT;
SELECT rpad(sys_context('USERENV', 'DB_UNIQUE_NAME'),15)  db_unique_name  FROM DUAL;
SELECT rpad(instance_name, 17) current_instance,rpad(to_char(current_timestamp,'DD-MON-YY HH24:MI'),17) current_timestamp FROM v$instance;
SET TERMOUT ON

set linesize 160
set pagesize 40
--clear columns
--clear breaks
define start_time='&1'
define end_time='&2'
ttitle off


PROMPT
PROMPT +--------------------------------------------------------------------------------------+
PROMPT   Report   : Session History  of Top 10 IO Query
PROMPT   Duration : Between &start_time and &end_time 
PROMPT   DB_Name  : &db_unique_name
PROMPT   Timestamp: &current_timestamp
PROMPT +--------------------------------------------------------------------------------------+



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
set verify off
col type for a15
col "CPU" for 999999.9
col "IO" for 999999.9
select * from (
select
     ash.SQL_ID , ash.SQL_PLAN_HASH_VALUE Plan_hash, aud.name type,
     sum(decode(ash.session_state,'ON CPU',1,0))     "CPU",
     sum(decode(ash.session_state,'WAITING',1,0))    -
     sum(decode(ash.session_state,'WAITING', decode(wait_class, 'User I/O',1,0),0))    "WAIT" ,
     sum(decode(ash.session_state,'WAITING', decode(wait_class, 'User I/O',1,0),0))    "IO" ,
     sum(decode(ash.session_state,'ON CPU',1,1))     "TOTAL"
from dba_hist_active_sess_history ash,
     audit_actions aud
where SQL_ID is not NULL
     and ash.sql_opcode=aud.action
    and ash.sample_time >= to_timestamp('&start_time', 'YYYY-MM-DD HH24:MI')
    and ash.sample_time <= to_timestamp('&end_time', 'YYYY-MM-DD HH24:MI') 
group by sql_id, SQL_PLAN_HASH_VALUE   , aud.name 
order by sum(decode(session_state,'ON CPU',1,1))   desc
) where  rownum <= 10
/