
set markup html on
SET TERMOUT OFF;
COLUMN current_instance NEW_VALUE current_instance NOPRINT;
COLUMN db_unique_name NEW_VALUE db_unique_name NOPRINT;
COLUMN current_timestamp NEW_VALUE current_timestamp  NOPRINT;
SELECT rpad(sys_context('USERENV', 'DB_UNIQUE_NAME'),15)  db_unique_name  FROM DUAL;
SELECT rpad(instance_name, 17) current_instance,rpad(to_char(current_timestamp,'DD-MON-YY HH24:MI'),17) current_timestamp FROM v$instance;
SET TERMOUT ON

PROMPT
PROMPT +--------------------------------+
PROMPT   Report   : DB Service Details
PROMPT   DB_Name  : &db_unique_name
PROMPT   Timestamp: &current_timestamp
PROMPT +--------------------------------+


-- view load balancing goal of a current service
-- NONE means load balancing advisory is disabled
PROMPT +-------------+
PROMPT TOTAL SERVICES
PROMPT +-------------+
set linesize 200
set pagesize 2000
SELECT NAME Service_name, GOAL, CLB_GOAL FROM DBA_SERVICES order by 1;


PROMPT +-----------+
PROMPT  SERVICES
PROMPT +-----------+
-- aggregated
col cpu_percall for 99999999 heading "CPU |Minute |per call"
col elap_time for 99999999 heading "Elapsed |Minute| per call"
col user_call for 99999999 heading  "User Calls/s"
col db_time for 99999999 heading "DB Time/s"
col group_id for 99  heading "Service|Metric|Group"
col service_name for a40
SELECT
rpad(service_name,40) service_name, group_id,
round(sum(CPUPERCALL)/60,2) cpu_percall,
round(sum(DBTIMEPERCALL)/60,2) elap_time, 
round(sum(CALLSPERSEC),2) user_call,
round(sum(DBTIMEPERSEC),2) db_time
from V$SERVICEMETRIC_HISTORY
group by SERVICE_NAME, group_id
having round(sum(CPUPERCALL)/60,2) > 0
order by 3 desc;

PROMPT  TAF failover
-- TAF failover 
col machine for a30
col service_name for a27
SELECT rpad(machine,30) machine, failover_method, failover_type,
failed_over, rpad(service_name,27) service_name, COUNT(*)
FROM gv$session
GROUP BY machine, failover_method, failover_type,
failed_over, service_name
order by 6 desc;


PROMPT +----------------------------------+
PROMPT  Failed Over Service Detail
PROMPT +----------------------------------+

col inst_id for 9999 head "Inst|id"
col username for a15
col "session" for a12 head "Sid|Serial#"
col service_name for a30 
select
   substr(service_name,1,30) service_name,
   username, 
   inst_id,sid||':'||serial# "session",
   failover_type, 
   failover_method, 
   failed_over,
   to_char(prev_exec_start,'mm/dd/yyyy hh24:mi') prev_exec_start,
   to_char(logon_time,'mm/dd/yyyy hh24:mi') logon_time
from
   gv$session
where
   username not in ('SYS','SYSTEM','PERFSTAT')
and
   failed_over = 'YES' order by service_name;