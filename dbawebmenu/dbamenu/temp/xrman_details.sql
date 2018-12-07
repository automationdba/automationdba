set markup html on 
SET SQLBLANKLINES ON
SET TERMOUT OFF;
COLUMN current_instance NEW_VALUE current_instance NOPRINT;
COLUMN db_unique_name NEW_VALUE db_unique_name NOPRINT;
COLUMN current_timestamp NEW_VALUE current_timestamp  NOPRINT;
SELECT rpad(sys_context('USERENV', 'DB_UNIQUE_NAME'),15)  db_unique_name  FROM DUAL;
SELECT rpad(instance_name, 17) current_instance,rpad(to_char(current_timestamp,'DD-MON-YY HH24:MI'),17) current_timestamp FROM v$instance;
SET TERMOUT ON

PROMPT
PROMPT +------------------------------------+
PROMPT   Report   : RMAN DB Backup Details 
PROMPT   DB_Name  : &db_unique_name
PROMPT   Timestamp: &current_timestamp
PROMPT +------------------------------------+

--LAST 10 DAYS JOBS
set linesize 200
set pagesize 200
COL in_size  FORMAT a10
COL out_size FORMAT a10
col STATUS for a20
col COMMAND_ID for a20
select SESSION_STAMP,SESSION_KEY,INPUT_TYPE, COMMAND_ID,to_char(START_TIME,'dd-mon-yyyy hh24:mi:ss') start_time,
INPUT_BYTES_DISPLAY in_size,OUTPUT_BYTES_DISPLAY out_size, 
to_char(END_TIME,'dd-mon-yyyy hh24:mi:ss') end_time,STATUS, round(ELAPSED_SECONDS/60) Minutes 
from V$RMAN_BACKUP_JOB_DETAILS where START_TIME > sysdate-10 order by to_date(START_TIME,'dd-mon-yyyy hh24:mi:ss');

PROMPT +------------------------------------+
PROMPT   RMAN Execution Command History
PROMPT +------------------------------------+
col OPERATION for a11
col output for a80
set linesize 140
set pagesize 500
col status for a12
col sid for 9999
col START_TIME for a16
select
a.sid,
a.recid,
to_char(b.start_time,'dd-mm-yy hh24:mi') "START_TIME",
b.operation,
b.status,
a.output
from v$rman_output a,
v$rman_status b
where a.rman_status_recid = b.recid
and a.rman_status_stamp = b.stamp
order by a.recid
/
