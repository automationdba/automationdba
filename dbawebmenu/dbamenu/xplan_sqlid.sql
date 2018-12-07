
set markup html on

define sql_id=&1
SET TERMOUT OFF;
COLUMN current_instance NEW_VALUE current_instance NOPRINT;
COLUMN db_unique_name NEW_VALUE db_unique_name NOPRINT;
COLUMN current_timestamp NEW_VALUE current_timestamp  NOPRINT;
SELECT rpad(sys_context('USERENV', 'DB_UNIQUE_NAME'),15)  db_unique_name  FROM DUAL;
SELECT rpad(instance_name, 17) current_instance,rpad(current_timestamp,22) current_timestamp FROM v$instance;
SET TERMOUT ON

PROMPT
PROMPT +------------------------------------------------------------------------+
PROMPT | Report   : Query explain plan for sqlid &1                             |
PROMPT | DB_Name  : &db_unique_name                                             |
PROMPT | Timestamp: &current_timestamp                                          |
PROMPT +------------------------------------------------------------------------+

set long 999999999
set linesize 200
set pagesize 300
set verify off

SELECT t.*
FROM gv$sql s, table(DBMS_XPLAN.DISPLAY_CURSOR(s.sql_id, s.child_number)) t 
WHERE s.sql_id='&&sql_id';
