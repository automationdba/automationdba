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
PROMPT | Report   : Query bind values of sqlid &1                               |
PROMPT | DB_Name  : &db_unique_name                                             |
PROMPT | Timestamp: &current_timestamp                                          |
PROMPT +------------------------------------------------------------------------+




col End_Interval for a20 heading 'End Interval|Time Stamp'
col Name for a10 heading 'Bind|Name'
col value_string for a20 heading 'Bind|Value'
set linesize 200
set pagesize 200
set verify off
select to_char(sn.END_INTERVAL_TIME,'MM/DD/YYYY HH24:MI:SS') End_Interval,
sb.NAME ,
sb.VALUE_STRING  Value_string,sb.datatype
from 
DBA_HIST_SQLBIND sb,
DBA_HIST_SNAPSHOT sn
where 
sb.sql_id='&&sqlid' and
sb.WAS_CAPTURED='YES' and
sn.snap_id=sb.snap_id
order by 
sb.snap_id,
sb.NAME;