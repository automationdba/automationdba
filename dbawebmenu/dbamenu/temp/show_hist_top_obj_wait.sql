
set markup html on
SET TERMOUT OFF;
COLUMN current_instance NEW_VALUE current_instance NOPRINT;
COLUMN db_unique_name NEW_VALUE db_unique_name NOPRINT;
COLUMN current_timestamp NEW_VALUE current_timestamp  NOPRINT;
SELECT rpad(sys_context('USERENV', 'DB_UNIQUE_NAME'),15)  db_unique_name  FROM DUAL;
SELECT rpad(instance_name, 17) current_instance,rpad(to_char(current_timestamp,'DD-MON-YY HH24:MI'),17) current_timestamp FROM v$instance;
SET TERMOUT ON

set verify off
set linesize 160
set pagesize 40
--clear columns
--clear breaks
define start_time='&1'
define end_time='&2'
ttitle off
 

PROMPT
PROMPT +--------------------------------------------------------------------------------------+
PROMPT   Report   : History session  of Top 5 Object wait
PROMPT   Duration : Between &start_time and &end_time 
PROMPT   DB_Name  : &db_unique_name
PROMPT   Timestamp: &current_timestamp
PROMPT +--------------------------------------------------------------------------------------+



col event format a40
col object_name format a40

select * from 
(
  select dba_objects.object_name,
 dba_objects.object_type,
active_session_history.event,
 sum(active_session_history.wait_time +
  active_session_history.time_waited) ttl_wait_time
from gv$active_session_history active_session_history,
    dba_objects
 where 
  active_session_history.sample_time >= to_timestamp('&start_time', 'YYYY-MM-DD HH24:MI')
  and active_session_history.sample_time <= to_timestamp('&end_time', 'YYYY-MM-DD HH24:MI')
and active_session_history.current_obj# = dba_objects.object_id
 group by dba_objects.object_name, dba_objects.object_type, active_session_history.event
 order by 4 desc)
where rownum < 6;