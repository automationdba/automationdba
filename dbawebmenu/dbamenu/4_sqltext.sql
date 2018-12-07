
set markup html on
undefine sqlid

define sqlid=&1


SET TERMOUT OFF;
COLUMN current_instance NEW_VALUE current_instance NOPRINT;
COLUMN db_unique_name NEW_VALUE db_unique_name NOPRINT;
COLUMN current_timestamp NEW_VALUE current_timestamp  NOPRINT;
SELECT rpad(sys_context('USERENV', 'DB_UNIQUE_NAME'),15)  db_unique_name  FROM DUAL;
SELECT rpad(instance_name, 17) current_instance,rpad(to_char(current_timestamp,'DD-MON-YY HH24:MI'),17) current_timestamp FROM v$instance;
SET TERMOUT ON

PROMPT
PROMPT +-------------------------------------------------------+
PROMPT   Report   : SQL Query Explain Plan
PROMPT   DB_Name  : &db_unique_name(Instance:&insname)
PROMPT   Timestamp: &current_timestamp
PROMPT +-------------------------------------------------------+


SET VERIFY OFF
SET FEEDBACK OFF
set heading off
set echo off
set flush off
set pagesize 400
set linesize 300
set long 4999
set longc 4999
 
--select sql_text from DBA_HIST_SQLTEXT where sql_id in ('6atk9g32crmsd')
--select sql_text,module from gv$sqlarea where sql_id in ('3')
--SELECT * FROM TABLE(dbms_xplan.display_cursor('3',1));
SELECT * FROM TABLE(dbms_xplan.display_awr('&sqlid'));