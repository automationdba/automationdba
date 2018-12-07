set markup html on
undefine insname
define insname=&1

SET TERMOUT OFF;
COLUMN current_instance NEW_VALUE current_instance NOPRINT;
COLUMN db_unique_name NEW_VALUE db_unique_name NOPRINT;
COLUMN current_timestamp NEW_VALUE current_timestamp  NOPRINT;
SELECT rpad(sys_context('USERENV', 'DB_UNIQUE_NAME'),15)  db_unique_name  FROM DUAL;
SELECT rpad(instance_name, 17) current_instance,rpad(to_char(current_timestamp,'DD-MON-YY HH24:MI'),17) current_timestamp FROM v$instance;
SET TERMOUT ON

PROMPT
PROMPT +----------------------------------------+
PROMPT   Report   : AWR Snap Detail
PROMPT   DB_Name  : &db_unique_name(Instance:&insname)
PROMPT   Timestamp: &current_timestamp
PROMPT +----------------------------------------+




set feedback off verify off pages 40 lines 80 trims on
col BEGIN format a18
col END format a15
col instance for 99 heading 'Inst'
 
select instance_number instance,snap_id,to_char(BEGIN_INTERVAL_TIME,'DD-MON-YY HH24:MI') Begin,to_char(END_INTERVAL_TIME,'DD-MON-YY HH24:MI') End
from dba_hist_snapshot
where END_INTERVAL_TIME between (sysdate - 1) and sysdate
and INSTANCE_NUMBER=&insname
order by snap_id desc
/