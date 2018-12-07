set markup html on
define sqlid=&1
SET TERMOUT OFF;
COLUMN current_instance NEW_VALUE current_instance NOPRINT;
COLUMN db_unique_name NEW_VALUE db_unique_name NOPRINT;
COLUMN current_timestamp NEW_VALUE current_timestamp  NOPRINT;
SELECT rpad(sys_context('USERENV', 'DB_UNIQUE_NAME'),15)  db_unique_name  FROM DUAL;
SELECT rpad(instance_name, 17) current_instance,rpad(current_timestamp,22) current_timestamp FROM v$instance;
SET TERMOUT ON

PROMPT
PROMPT +------------------------------------------------------------------------+
PROMPT | Report   : Current Plan Progress of sqlid &1                           |
PROMPT | DB_Name  : &db_unique_name                                             |
PROMPT | Timestamp: &current_timestamp                                          |
PROMPT +------------------------------------------------------------------------+


set linesize 200
set pagesize 40
col sql_plan_hash_value for 9999999999 heading 'Sql|Plan Hash'
col rows_processed for 999999999 heading 'Rows|Processed'

set verify off
col last_load for a19 heading "Last Load Time"
col plan_hash_value for 9999999999 heading "Plan|Hash Value"
select plan_hash_value,to_char(LAST_LOAD_TIME,'DD-MON-YY HH24:MI:SS') last_load,SORTS,FETCHES,EXECUTIONS,PARSE_CALLS,DISK_READS,DIRECT_WRITES,BUFFER_GETS,ROWS_PROCESSED,HASH_VALUE,OBJECT_STATUS from gv$sqlarea where SQL_ID = '&&sqlid';