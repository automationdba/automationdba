set markup html on

-- sessions with highest CPU +DB consumption(Last 4 hours Logged session)



SET TERMOUT OFF;
COLUMN current_instance NEW_VALUE current_instance NOPRINT;
COLUMN db_unique_name NEW_VALUE db_unique_name NOPRINT;
COLUMN current_timestamp NEW_VALUE current_timestamp  NOPRINT;
SELECT rpad(sys_context('USERENV', 'DB_UNIQUE_NAME'),15)  db_unique_name  FROM DUAL;
SELECT rpad(instance_name, 17) current_instance,rpad(to_char(current_timestamp,'DD-MON-YY HH24:MI'),17) current_timestamp FROM v$instance;
SET TERMOUT ON

PROMPT
PROMPT +------------------------------------------------------------------------+
PROMPT   Report   : Top CPU Sessions
PROMPT   DB_Name  : &db_unique_name
PROMPT   Timestamp: &current_timestamp
PROMPT +------------------------------------------------------------------------+


set linesize 200
set pagesize 160
col username format a10
col module format a22
col connected format A17 heading "Connected"
col "DB sec" format 99999999 heading "DB|sec"
col "CPU sec" format 99999999 heading "CPU|sec"

--col sid for 9999
--col serial# for 99999
col spid for a7 heading "OS PID"
col BLOCKING_SESSION_STATUS for a11 heading "Blocking"
col inst_id for 99 heading "Inst"
col MACHINE for a23 heading "machine"
col sess for a12 heading 'SID|Serial#'
col WAIT_CLASS for a15
col service_name for a15
col blocks for a10 heading "Blocking|Session"
col waits for 99999
SELECT s.inst_id,'('||s.sid||','||s.serial#||')' sess, p.spid,s.username, TO_CHAR(S.LOGON_TIME,'YYYY-MM-DD HH24:MI') connected,substr(s.module,1,22) module, st.value/100 as "CPU sec",st2.value/100 as "DB sec",s.blocking_session_status,s.MACHINE,s.sql_id
--,s.WAIT_CLASS,s.service_name,'('||BLOCKING_INSTANCE||','||BLOCKING_SESSION||')' blocks
FROM gv$sesstat st, gv$statname sn, gv$session s, gv$process p, gv$sesstat st2 ,gv$statname sn2
WHERE sn.name = 'CPU used by this session' -- CPU
AND sn2.name = 'DB time' -- CPU
AND st2.statistic# = sn2.statistic#
and s.inst_id=st.inst_id and p.inst_id=s.inst_id and sn.inst_id=st.inst_id
and s.inst_id=st2.inst_id  and sn2.inst_id=st2.inst_id
AND st.statistic# = sn.statistic#
AND st.sid = s.sid
AND st2.sid = s.sid
AND s.paddr = p.addr
and blocking_session_status <> 'NO HOLDER'
--AND s.last_call_et < 1800 -- active within last 1/2 hour
--AND s.logon_time > (SYSDATE - 240/1440) -- sessions logged on within 4 hours
ORDER BY st.value desc;
