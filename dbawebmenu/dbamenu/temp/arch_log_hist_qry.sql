
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
PROMPT | Report   : Arch Log Gap Report                                         |
PROMPT | DB_Name  : &db_unique_name                                             |
PROMPT | Timestamp: &current_timestamp                                        |
PROMPT +------------------------------------------------------------------------+

SET ECHO        OFF
SET FEEDBACK    6
SET HEADING     ON
SET LINESIZE    256
SET PAGESIZE    50000
SET TERMOUT     ON
SET TIMING      OFF
SET TRIMOUT     ON
SET TRIMSPOOL   ON
SET VERIFY      OFF

PROMPT
PROMPT +-------------------+
PROMPT   CHECK ARCHIVE GAP 
PROMPT +-------------------+
PROMPT
col "Last Sequence Received" heading ' Last Sequence| Received'
col "Last Sequence Applied" heading ' Last Sequence| Applied'
SELECT A.TRD_ARCHIVED, A.LOG_ARCHIVED, B.LOG_APPLIED, B.APPLIED_TIME, A.LOG_ARCHIVED - B.LOG_APPLIED AS LOG_GAP
FROM
(SELECT THREAD# TRD_ARCHIVED, MAX(SEQUENCE#) LOG_ARCHIVED
FROM V$ARCHIVED_LOG WHERE ARCHIVED='YES' GROUP BY THREAD#) A,
(SELECT THREAD# TRD_APPLIED, MAX(SEQUENCE#) LOG_APPLIED, TO_CHAR(MAX(COMPLETION_TIME),'MON-DD-YYYY HH24:MI:SS') APPLIED_TIME
FROM V$ARCHIVED_LOG WHERE APPLIED='YES' GROUP BY THREAD#) B
WHERE A.TRD_ARCHIVED=B.TRD_APPLIED
ORDER BY 1;

alter session set nls_date_format ='DD-MON-YY HH24:MI:SS';
PROMPT
PROMPT +----------------------------------------------------+
PROMPT   TOTAL NUMBER OF ARCHIVE LOGS GENERATED(EACH HOUR)
PROMPT +----------------------------------------------------+
PROMPT

col MidN format 9999
col 1AM format 9999
col 2AM format 9999
col 3AM format 9999
col 4AM format 9999
col 5AM format 9999
col 6AM format 9999
col 7AM format 99999
col 8AM format 99999
col 9AM format 9999
col 10AM format 9999
col 11AM format 9999
col Noon format 9999
col 1PM format 9999
col 2PM format 9999
col 3PM format 9999
col 4PM format 9999
col 5PM format 9999
col 6PM format 9999
col 7PM format 9999
col 8PM format 9999
col 9PM format 9999
col 10PM format 9999
col 11PM format 9999
select to_char(first_time,'mm/dd/yy') logdate,
sum(decode(to_char(first_time,'hh24'),'00',1,0)) "MidN",
sum(decode(to_char(first_time,'hh24'),'01',1,0)) "1AM",
sum(decode(to_char(first_time,'hh24'),'02',1,0)) "2AM",
sum(decode(to_char(first_time,'hh24'),'03',1,0)) "3AM",
sum(decode(to_char(first_time,'hh24'),'04',1,0)) "4AM",
sum(decode(to_char(first_time,'hh24'),'05',1,0)) "5AM",
sum(decode(to_char(first_time,'hh24'),'06',1,0)) "6AM",
sum(decode(to_char(first_time,'hh24'),'07',1,0)) "7AM",
sum(decode(to_char(first_time,'hh24'),'08',1,0)) "8AM",
sum(decode(to_char(first_time,'hh24'),'09',1,0)) "9AM",
sum(decode(to_char(first_time,'hh24'),'10',1,0)) "10AM",
sum(decode(to_char(first_time,'hh24'),'11',1,0)) "11AM",
sum(decode(to_char(first_time,'hh24'),'12',1,0)) "Noon",
sum(decode(to_char(first_time,'hh24'),'13',1,0)) "1PM",
sum(decode(to_char(first_time,'hh24'),'14',1,0)) "2PM",
sum(decode(to_char(first_time,'hh24'),'15',1,0)) "3PM",
sum(decode(to_char(first_time,'hh24'),'16',1,0)) "4PM",
sum(decode(to_char(first_time,'hh24'),'17',1,0)) "5PM",
sum(decode(to_char(first_time,'hh24'),'18',1,0)) "6PM",
sum(decode(to_char(first_time,'hh24'),'19',1,0)) "7PM",
sum(decode(to_char(first_time,'hh24'),'20',1,0)) "8PM",
sum(decode(to_char(first_time,'hh24'),'21',1,0)) "9PM",
sum(decode(to_char(first_time,'hh24'),'22',1,0)) "10PM",
sum(decode(to_char(first_time,'hh24'),'23',1,0)) "11PM"
from v$log_history
where first_time > sysdate-8
group by to_char(first_time,'mm/dd/yy')
order by 1;


PROMPT
PROMPT +-----------------------------------------------+
PROMPT   CHECK IF ANY DATAGUARD RELATED ERROR GENERATED
PROMPT +-----------------------------------------------+
PROMPT
-- Determine if any error conditions have been reached by querying the v$dataguard_status
-- view (view only available in 9.2.0 and above):
column message format a80
select message, timestamp
from v$dataguard_status
where severity in ('Error','Fatal')
order by timestamp;

PROMPT
PROMPT +------------------------------+
PROMPT   FLASH RECOVERY AREA STATUS
PROMPT +------------------------------+
PROMPT
select * from v$flash_recovery_area_usage;

--col name for a40
--SELECT NAME,
---ROUND(SPACE_LIMIT / 1048576) SPACE_LIMIT_MB,
--ROUND(SPACE_USED / 1048576) SPACE_USED_MB,
--ROUND(((SPACE_USED / 1048576) * 100) / (SPACE_LIMIT / 1048576), 2) PRC_USED
--FROM VRECOVERY_FILE_DEST; 

select distinct INST_ID,PROCESS, CLIENT_PROCESS,SEQUENCE#,THREAD#,STATUS from gv$managed_standby order by 1,2,3,4;

col Name for a40
SELECT distinct a.NAME, ROUND(a.SPACE_LIMIT/1024/1024/1024,2) SPACE_LIMIT_GB,
ROUND((a.SPACE_LIMIT - a.SPACE_USED + a.SPACE_RECLAIMABLE)/1024/1024/1024,2) SPACE_AVAILABLE_GB,
ROUND((a.SPACE_USED - a.SPACE_RECLAIMABLE)/a.SPACE_LIMIT*100,2) PERCENT_FULL,
round(b.TOTAL_MB/1000) DG_SPACE_TOTAL_GB, round(b.FREE_MB/1000)  DG_SPACE_FREE_GB
FROM V$RECOVERY_FILE_DEST a, gV$ASM_DISKGROUP b
where b.name=substr(a.name,2);


PROMPT
PROMPT +-------------------------+
PROMPT   OUTSTANDING ALERT(IF ANY)
PROMPT +-------------------------+
PROMPT
PROMPT Note:warning alert when reclaimable space is less than 15% and a critical alert when reclaimable space is less than 3%
PROMPT
set linesize 200
set pagesize 200	
col INSTANCE_NAME for a6 heading 'Inst|Name'
col MESSAGE_LEVEL for 999 heading 'Mess|lvl'
col OBJECT_TYPE for a14
col REASON for a80
col SUGGESTED_ACTION for a40
 select 
  to_char(creation_time, 'dd-mm-yyyy hh24:mi') crt,
  instance_name,         
  object_type,           
  message_type,        
  message_level,      
  reason,            
  suggested_action 
from
  dba_outstanding_alerts
 order by
     creation_time;	