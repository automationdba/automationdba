
SET TERMOUT OFF;
COLUMN current_instance NEW_VALUE current_instance NOPRINT;
COLUMN db_unique_name NEW_VALUE db_unique_name NOPRINT;
COLUMN current_timestamp NEW_VALUE current_timestamp  NOPRINT;
SELECT rpad(sys_context('USERENV', 'DB_UNIQUE_NAME'),15)  db_unique_name  FROM DUAL;
SELECT rpad(instance_name, 17) current_instance,rpad(to_char(current_timestamp,'DD-MON-YY HH24:MI'),17) current_timestamp FROM v$instance;
 
 

define sqlid =&1
define report_name = &2 
set verify off 
SET TERMOUT ON

PROMPT
PROMPT +------------------------------------------------------------------------+
PROMPT   Report   	: sql tune report list of sql_id : &sqlid
PROMPT   DB_Name  	: &db_unique_name
PROMPT   Report Time 	: &current_timestamp
PROMPT +------------------------------------------------------------------------+


SET LONG 1000000
SET LONGCHUNKSIZE 1000000
SET LINESIZE 1000
SET PAGESIZE 0
SET TRIM ON
SET TRIMSPOOL ON
SET ECHO OFF
SET FEEDBACK OFF

SPOOL '&report_name'
SELECT DBMS_SQLTUNE.report_sql_detail(
  sql_id       => '&sqlid',
  type         => 'ACTIVE',
  report_level => 'ALL') AS report
FROM dual;



SPOOL OFF