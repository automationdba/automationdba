
set markup html on
undefine insname
undefine fsnap
undefine ssnap
undefine event
 

define insname=&1
define fsnap=&2
define ssnap=&3
define event=&4

SET TERMOUT OFF;
COLUMN current_instance NEW_VALUE current_instance NOPRINT;
COLUMN db_unique_name NEW_VALUE db_unique_name NOPRINT;
COLUMN current_timestamp NEW_VALUE current_timestamp  NOPRINT;
SELECT rpad(sys_context('USERENV', 'DB_UNIQUE_NAME'),15)  db_unique_name  FROM DUAL;
SELECT rpad(instance_name, 17) current_instance,rpad(to_char(current_timestamp,'DD-MON-YY HH24:MI'),17) current_timestamp FROM v$instance;
SET TERMOUT ON

PROMPT
PROMPT +-------------------------------------------------------------------------+
PROMPT   Report   : AWR SQL Id for specific Wait(Between snap &fsnap and &ssnap)
PROMPT   DB_Name  : &db_unique_name(Instance:&insname)
PROMPT   Timestamp: &current_timestamp
PROMPT +-------------------------------------------------------------------------+




set verify off

select sql_id, count(*) cnt from dba_hist_active_sess_history
where snap_id between &fsnap and &ssnap 
and event_id=&event
and instance_number=&insname
group by sql_id
having count(*)>1
order by 2;