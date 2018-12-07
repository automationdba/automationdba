
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
PROMPT   Report   : Undo Space detail
PROMPT   DB_Name  : &db_unique_name
PROMPT   Timestamp: &current_timestamp
PROMPT +--------------------------------+

set linesize 200
set pagesize 200
col tablespace_name for a20
col size_gb for 999,999.9
select tablespace_name, round(sum(bytes/1024/1024/1024),2) size_gb, status, sum(blocks) sum_blks
from dba_undo_extents group by status,tablespace_name order by tablespace_name, status;

PROMPT +------------+
PROMPT   UNDO USAGE
PROMPT +------------+
select a.tablespace_name, round(SIZEGB,2) SIZE_GB, round(USAGEGB,2) USED_GB, round((SIZEGB-USAGEGB),2) FREE_GB
from (select sum(bytes)/1024/1024/1024 SIZEGB, b.tablespace_name
from dba_data_files a, dba_tablespaces b
where a.tablespace_name = b.tablespace_name
and b.contents = 'UNDO'
group by b.tablespace_name) a,
(select c.tablespace_name, sum(bytes)/1024/1024/1024 USAGEGB
from DBA_UNDO_EXTENTS c
where status <> 'EXPIRED'
group by c.tablespace_name) b
where a.tablespace_name = b.tablespace_name;

PROMPT +------------+
PROMPT   UNDO RECOVER
PROMPT +------------+
col etime heading "Estimated time | to complete"
col usn heading "Undo seg|num"
alter session set NLS_DATE_FORMAT='DD-MON-YYYY HH24:MI:SS';
select usn, state, undoblockstotal "Total", undoblocksdone "Done", undoblockstotal-undoblocksdone "ToDo",
decode(cputime,0,'unknown',sysdate+(((undoblockstotal-undoblocksdone) / (undoblocksdone / cputime)) / 86400)) etime
from v$fast_start_transactions;

col sid_serial for a10
col Undo_usage for  a12
col orauser for  a20
col inst_id for 9999 heading 'Inst'


PROMPT +---------------+
PROMPT   UNDO SESSIONS
PROMPT +---------------+
SELECT s.Inst_id,TO_CHAR (s.SID) || ',' || TO_CHAR (s.serial#) sid_serial,
NVL (s.username, 'None') orauser,round(t.used_ublk * TO_NUMBER (x.VALUE) / 1024/1024,2) || 'M' "Undo_usage", s.status
,to_char(t.START_DATE,'DD-MON-YYYY HH24:MI') trns_start_date,SQL_ID,PREV_SQL_ID,SQL_HASH_VALUE,substr(SERVICE_NAME,1,20) service_name
FROM SYS.v_$rollname r,
SYS.gv_$session s,
SYS.gv_$transaction t,
SYS.gv_$parameter x
WHERE s.taddr = t.addr and s.inst_id=t.inst_id and s.inst_id=x.inst_id
AND r.usn = t.xidusn(+) 
AND x.NAME = 'db_block_size'
ORDER BY round(t.used_ublk * TO_NUMBER (x.VALUE) / 1024/1024,2) desc;