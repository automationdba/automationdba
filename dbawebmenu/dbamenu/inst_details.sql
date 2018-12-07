set markup html on

SET TERMOUT OFF;
COLUMN current_instance NEW_VALUE current_instance NOPRINT;
COLUMN db_unique_name NEW_VALUE db_unique_name NOPRINT;
COLUMN current_timestamp NEW_VALUE current_timestamp  NOPRINT;
SELECT rpad(sys_context('USERENV', 'DB_UNIQUE_NAME'),15)  db_unique_name  FROM DUAL;
SELECT rpad(instance_name, 17) current_instance,rpad(to_char(current_timestamp,'DD-MON-YY HH24:MI'),17) current_timestamp FROM v$instance;
SET TERMOUT ON

PROMPT
PROMPT +----------------------------------------+
PROMPT   Report   : Database All Instance Detail
PROMPT   DB_Name  : &db_unique_name
PROMPT   Timestamp: &current_timestamp
PROMPT +----------------------------------------+

set feed off
col host_name for a35
col INSTANCE_NUMBER for 999 heading 'Instance|Number'
select inst_id,instance_number,instance_name,host_name,status,DATABASE_STATUS,INSTANCE_ROLE from gv$instance
order by 1
/