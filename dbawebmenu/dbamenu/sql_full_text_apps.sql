
set markup html on
define sql_id='&1'
SET TERMOUT OFF;
COLUMN current_instance NEW_VALUE current_instance NOPRINT;
COLUMN db_unique_name NEW_VALUE db_unique_name NOPRINT;
COLUMN current_timestamp NEW_VALUE current_timestamp  NOPRINT;
SELECT rpad(sys_context('USERENV', 'DB_UNIQUE_NAME'),15)  db_unique_name  FROM DUAL;
SELECT rpad(instance_name, 17) current_instance,rpad(current_timestamp,22) current_timestamp FROM v$instance;
SET TERMOUT ON

PROMPT
PROMPT +------------------------------------------------------------------------+
PROMPT | Report   : Query text of sqlid  	&1   	                                |
PROMPT | DB_Name  : &db_unique_name                                             |
PROMPT | Timestamp: &current_timestamp                                          |
PROMPT +------------------------------------------------------------------------+


set linesize 200
--set term off
set pagesize 2000
set long 20000
set verify off

col sql_text format A132
prompt
prompt +------------------------------------------+
prompt  SQL Text of &sql_id from History
prompt +------------------------------------------+
prompt
select  sql_text from DBA_HIST_SQLTEXT where  sql_id='&sql_id';