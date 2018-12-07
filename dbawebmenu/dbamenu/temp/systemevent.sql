set markup html on
SET TERMOUT OFF;
COLUMN current_instance NEW_VALUE current_instance NOPRINT;
COLUMN db_unique_name NEW_VALUE db_unique_name NOPRINT;
COLUMN current_timestamp NEW_VALUE current_timestamp  NOPRINT;
SELECT rpad(sys_context('USERENV', 'DB_UNIQUE_NAME'),15)  db_unique_name  FROM DUAL;
SELECT rpad(instance_name, 17) current_instance,rpad(to_char(current_timestamp,'DD-MON-YY HH24:MI'),17) current_timestamp FROM v$instance;
define userin=&1
 
SET TERMOUT ON

PROMPT
PROMPT +------------------------------------------------------------------------+
PROMPT   Report   	: Current system wait event details(instance specific)
PROMPT   DB_Name  	: &db_unique_name
PROMPT   Report Time 	: &current_timestamp
PROMPT +------------------------------------------------------------------------+


/**********************************************************************
* File: systemevent.sql
* Type: SQL*Plus script
* Description:
* This is possibly one of the most useful tuning scripts
* available.
*
* The V$SYSTEM_EVENT dynamic performance view is the highest-level
* view of the "Session Wait Interface". Information in this view
* is cumulative since the database instance was started, and one
* can get a very good idea of what types of contention a database
* instance is (or is not) experiencing by monitoring this view.
*
* NOTE: this script sorts output by the TIME_WAITED column in the
* V$SYSTEM_EVENT view. If the Oracle initialization parameter
* TIMED_STATISTICS is not set to TRUE, then the TIME_WAITED
* column will not be populated.
*
* Please *disregard* the advice of people who insist that turning
* off TIMED_STATISTICS is somehow a performance boost. Whatever
* performance overhead that might be incurred is more than
* compensated for by the incredible tuning information that
* results...
*
*********************************************************************/
set echo off feedback off timing off pause off verify off
set pagesize 80 linesize 500 trimspool on trimout on
col event format a26 truncate heading "Event Name"
col total_waits format 999,999,990 heading "Total|Waits|(in 1000s)"
col total_timeouts format 999,999,990 heading "Total|Timeouts|(in 1000s)"
col time_waited format 999,990.00 heading "Time|Waited|(in Hours)"
col pct_significant format 90.00 heading "% of|Concern"
col average_wait format 999,990.00 heading "Avg|Wait|(Secs)"

col total_time_waited new_value V_TOTAL_TIME_WAITED noprint
select sum(time_waited) total_time_waited
from sys.v_$system_event
where event not in ('SQL*Net message from client',
'rdbms ipc message',
'slave wait',
'pmon timer',
'smon timer',
'rdbms ipc reply',
'SQL*Net message to client',
'SQL*Net break/reset to client',
'inactive session',
'Null event')
/


select event,
(total_waits / 1000) total_waits,
(total_timeouts / 1000) total_timeouts,
(time_waited / 360000) time_waited,
decode(event,
'SQL*Net message from client', 0,
'rdbms ipc message', 0,
'slave wait', 0,
'pmon timer', 0,
'smon timer', 0,
'rdbms ipc reply', 0,
'SQL*Net message to client', 0,
'SQL*Net break/reset to client', 0,
'inactive session', 0,
'Null event', 0,
(time_waited / &&V_TOTAL_TIME_WAITED)*100) pct_significant,
(average_wait / 100) average_wait
from sys.v_$system_event
where (time_waited/360000) >= 0.01
order by pct_significant desc, time_waited desc
/