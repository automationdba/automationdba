set markup html on
 
 

SET TERMOUT OFF;
COLUMN current_instance NEW_VALUE current_instance NOPRINT;
COLUMN db_unique_name NEW_VALUE db_unique_name NOPRINT;
COLUMN current_timestamp NEW_VALUE current_timestamp  NOPRINT;
SELECT rpad(sys_context('USERENV', 'DB_UNIQUE_NAME'),15)  db_unique_name  FROM DUAL;
SELECT rpad(instance_name, 17) current_instance,rpad(to_char(current_timestamp,'DD-MON-YY HH24:MI'),17) current_timestamp FROM v$instance;
SET TERMOUT ON

PROMPT
PROMPT +----------------------------------------------------------+
PROMPT   Report   : DML Active sessions   
PROMPT   DB_Name  : &db_unique_name 
PROMPT   Timestamp: &current_timestamp
PROMPT +----------------------------------------------------------+

-- Query : rac_long_run_txn.sql 
-- The following query (to be run by a DBA) lists for currently 
-- active transactions who is running them (username + program 
-- info when available, complete with session id ready to be used 
-- in an 'ALTER SYSTEM KILL SESSION' command), the text of the 
-- associated SQL query, how many rollback segment blocks we have
-- used so far and for how long the transaction has been running
-- (in seconds), and the name of the table(s) on which the running
-- transaction has put row-locks. 
--
-- Note that some innocent-looking UPDATE can indeed put row-locks
-- on many tables if there are triggers updating, inserting or
-- deleting other tables. Transactions are ordered by duration 
-- (transactions which have been running the longer first). 
-- 
-- This is quite useful for monitoring long-running updates and 
-- locking problems. 
PROMPT
PROMPT +------------------------------------------------+
PROMPT   DML Long Running Transactions
PROMPT +------------------------------------------------+
PROMPT

set pagesize 2000
set linesize 200
set recsep off 
column "WHO" format A37 
column "TABLE" format A20 
column "TEXT" format A45 word_wrapped 
column "RB BLKS/S RUNNING" format A14 head 'RB BLKS|S Running' 
clear breaks 
break on "WHO" on "ROLLBACK BLOCKS" on "RB BLKS/S RUNNING" on "TEXT" skip 1 
select to_char(se.sid ) || ',' || to_char(se.serial#) || '@' ||to_char(se.inst_id)||' '|| se.username || 
       '/' ||decode(ltrim(se.module || ' ' || se.action || ' ' || se.client_info),
       '', se.program,ltrim(se.module || ' ' || se.action || ' ' || se.client_info)) "WHO",
       s.sql_text "TEXT",to_char(x.used_ublk )||'/'|| to_char((sysdate-to_date(x.start_time,
      'MM/DD/RR HH24:MI:SS'))*86400) "RB BLKS/S RUNNING",o.name "TABLE" 
from gv$sqlarea s,
     gv$session se,
     sys.obj$ o,
     gv$locked_object l,
     gv$transaction x,
     gv$lock l2 
where 
  s.inst_id=se.inst_id
  and se.inst_id=l.inst_id
  and se.inst_id=x.inst_id
  and se.inst_id=l2.inst_id
  and se.sql_address = s.address 
  and x.ses_addr = se.saddr 
  and o.obj# = l.object_id 
  and l.xidusn = x.xidusn 
  and l.xidslot = x.xidslot 
  and l.xidsqn = x.xidsqn 
  and l2.id2 = x.xidsqn 
  and l2.id1 = 65536 * x.xidusn + x.xidslot 
  and l2.type = 'TX' 
order by (sysdate-to_date(x.start_time,'MM/DD/RR HH24:MI:SS'))*86400 desc,1,4;