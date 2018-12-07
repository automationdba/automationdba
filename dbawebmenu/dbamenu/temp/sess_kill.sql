set markup html on
SET TERMOUT OFF;
COLUMN current_instance NEW_VALUE current_instance NOPRINT;
COLUMN db_unique_name NEW_VALUE db_unique_name NOPRINT;
COLUMN current_timestamp NEW_VALUE current_timestamp  NOPRINT;
SELECT rpad(sys_context('USERENV', 'DB_UNIQUE_NAME'),15)  db_unique_name  FROM DUAL;
SELECT rpad(instance_name, 17) current_instance,rpad(to_char(current_timestamp,'DD-MON-YY HH24:MI'),17) current_timestamp FROM v$instance;
SET TERMOUT ON
define sqlid=&1
 
PROMPT
PROMPT +--------------------------------------------------------------------------------------+
PROMPT   Report   : Session Kill syntax
PROMPT   sql_id   : &1 
PROMPT   DB_Name  : &db_unique_name
PROMPT   Timestamp: &current_timestamp
PROMPT +--------------------------------------------------------------------------------------+




set pagesize 100

set feed off
set linesize 100
set pagesize 0
set verify off
PROMPT
PROMPT +---------------------------------------------------------------------------+
PROMPT   Session Kill syntax for all existing users running with sql_id &sqlid
PROMPT +---------------------------------------------------------------------------+
select 'ALTER SYSTEM KILL SESSION '||''''||SID||','||SERIAL#||',@'||INST_ID||''''||' IMMEDIATE;'
from gv$session 
where 
 sql_id = '&&sqlid'
 --sql_id like lower('&&sqlid')
and status <>  'KILLED'
order by inst_id,sid,serial#
/
PROMPT
PROMPT
PROMPT +------------------------------------------------------------------------+
PROMPT | FLUSH PLAN QUERY SYNTAX                                                |
PROMPT +------------------------------------------------------------------------+
select 'exec sys.dbms_shared_pool.purge('''||address||','||hash_value||''',''c'',1);' Flush_Plan_Syntax  from v$sqlarea where sql_id like '&&sqlid'
/