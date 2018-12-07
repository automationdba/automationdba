
set markup html on

define sqlid=&1

SET TERMOUT OFF;
COLUMN current_instance NEW_VALUE current_instance NOPRINT;
COLUMN db_unique_name NEW_VALUE db_unique_name NOPRINT;
COLUMN current_timestamp NEW_VALUE current_timestamp  NOPRINT;
SELECT rpad(sys_context('USERENV', 'DB_UNIQUE_NAME'),15)  db_unique_name  FROM DUAL;
SELECT rpad(instance_name, 17) current_instance,rpad(to_char(current_timestamp,'DD-MON-YY HH24:MI'),17) current_timestamp FROM v$instance;
SET TERMOUT ON

PROMPT
PROMPT +---------------------------------------------------------------+
PROMPT   Report   : Change sql_id (&sqlid)
PROMPT   DB_Name  : &db_unique_name 
PROMPT   Timestamp: &current_timestamp
PROMPT +----------------------------------------------------------------+

set verify off
col Last_Load_Time for a12 heading 'Last Load|Time'
col PLAN_HASH_VALUE for 9999999999 heading 'Plan|Hash Value'
col SQL_Text for a70 heading 'SQL TEXT(first 210 text)'
col username for a25 heading "Username"
set linesize 200
set pagesize 100
select a.SQL_ID,a.PLAN_HASH_VALUE,to_char(a.LAST_LOAD_TIME,'MM/DD:HH24:MI') Last_Load_Time,b.sql_id,b.PLAN_HASH_VALUE,to_char(b.LAST_LOAD_TIME,'MM/DD:HH24:MI') Last_Load_Time,
substr(a.sql_text,1,210) SQL_Text 
from gv$sqlarea a,gv$sqlarea b
where a.SQL_TEXT=b.SQL_TEXT
and a.SQL_ID <> b.SQL_ID
and a.plan_hash_value <> b.plan_hash_value
and a.sql_id < b.sql_id
and a.sql_id='&&sqlid'
order by 3;