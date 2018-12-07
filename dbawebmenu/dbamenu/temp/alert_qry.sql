
set markup html on
set linesize 200
col MESSAGE_TEXT for a120
col alert_time  format a20
set pagesize 100

col instance_id heading 'INS'
col user_id for a10
col host_id for a10
set markup html on
SET TERMOUT OFF;
COLUMN current_instance NEW_VALUE current_instance NOPRINT;
COLUMN db_unique_name NEW_VALUE db_unique_name NOPRINT;
COLUMN current_timestamp NEW_VALUE current_timestamp  NOPRINT;
SELECT rpad(sys_context('USERENV', 'DB_UNIQUE_NAME'),15)  db_unique_name  FROM DUAL;
SELECT rpad(instance_name, 17) current_instance,rpad(current_timestamp,22) current_timestamp FROM v$instance;
SET TERMOUT ON

PROMPT
PROMPT +------------------------------------------------------------------------+
PROMPT | Report   : Alert Log Query (ORA-%) {latest 2 Days Only}                |
PROMPT | DB_Name  : &db_unique_name                                             |
PROMPT | Timestamp: &current_timestamp                                          |
PROMPT +------------------------------------------------------------------------+


select distinct MESSAGE_TEXT,to_char(ORIGINATING_TIMESTAMP,'DD-MON-YY HH24:MI') alert_time, instance_id, user_id,host_id from V$DIAG_ALERT_EXT where 
MESSAGE_TEXT like 'ORA-%' and  
ORIGINATING_TIMESTAMP  > systimestamp - interval '2' day
order by alert_time desc
/