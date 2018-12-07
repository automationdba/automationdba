

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
PROMPT | Report   : Gateway/Agent                                               |
PROMPT | DB_Name  : &db_unique_name                                             |
PROMPT | Timestamp: &current_timestamp                                      |
PROMPT +------------------------------------------------------------------------+


set linesize 200
set pagesize 40
col start_time for a15 heading 'Agent|Start Time'
col agent_database for a13 heading 'Agent|Database'
col QUEUE_NAME for a30 heading 'Queue Name'
col LAST_ERROR_MSG for a60 heading 'Last error message'
col SUBSCRIBER_ID for a16 heading 'Subscriber Id'
col PROPAGATION_TYPE for a15 heading 'Propagation|type'
col LAST_ERROR_DATE for a12 heading 'Last error|Date'
PROMPT
PROMPT
PROMPT +------------------------------------------------------------------------+
PROMPT | GATEWAY STATUS                                                         |
PROMPT +------------------------------------------------------------------------+

select AGENT_DATABASE,agent_status, agent_ping,to_char(agent_start_time,'DD-MON-YY HH24:MI') start_time from mgw_gateway;
PROMPT
PROMPT
PROMPT +------------------------------------------------------------------------+
PROMPT | GATEWAY SUBSCRIBER DETAIL                                              |
PROMPT +------------------------------------------------------------------------+

select SUBSCRIBER_ID, PROPAGATION_TYPE, QUEUE_NAME, FAILURES,LAST_ERROR_TIME,LAST_ERROR_DATE, LAST_ERROR_MSG from mgw_subscribers;