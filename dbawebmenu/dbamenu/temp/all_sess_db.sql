
set markup html on
--------------------------------------------------------------------------------------
-- Show all Sessions along with their PID and Client Process IDs  with Summary
--------------------------------------------------------------------------------------

 

SET TERMOUT OFF;
COLUMN current_instance NEW_VALUE current_instance NOPRINT;
COLUMN db_unique_name NEW_VALUE db_unique_name NOPRINT;
COLUMN current_timestamp NEW_VALUE current_timestamp  NOPRINT;
SELECT rpad(sys_context('USERENV', 'DB_UNIQUE_NAME'),15)  db_unique_name  FROM DUAL;
SELECT rpad(instance_name, 17) current_instance,rpad(to_char(current_timestamp,'DD-MON-YY HH24:MI'),17) current_timestamp FROM v$instance;
SET TERMOUT ON

PROMPT
PROMPT +------------------------------------------------------------------------+
PROMPT   Report   : Show All Sessions
PROMPT   DB_Name  : &db_unique_name
PROMPT   Timestamp: &current_timestamp
PROMPT +------------------------------------------------------------------------+

set linesize 160
set pagesize 100
clear columns
clear breaks
ttitle off

column usr                 format a17       Heading 'Osuser  /User'
column sid                 format 9999      heading 'S|I|D'
column connected           format A19       heading 'Connected'
column stat                format A1        heading 'S|t|a|t'
column serial              format 999999    heading 'Serial#'
column server              format 99999   heading 'PID'
column client              format 9999999  heading 'Clnt-Process'
column machine             format A20       heading 'Machine'
column module              format A30       heading 'Module'
column Instance            format A13       heading 'Inst|Sid,Serial#'


set verify off

-- Background processes
SELECT rpad(S.OSUSER,8)||'/'||
       substr(s.program,instr(s.program,' ')) Usr,
       TO_CHAR(S.LOGON_TIME,'YYYY-MM-DD HH24:MI:SS') connected,
	   S.Inst_id||':'||S.SID||','||S.SERIAL# Instance,substr(S.STATUS,1,1) STAT, p.spid server, s.process client,
       substr(S.MACHINE,1,20) MACHINE, substr(S.MODULE,1,30) module
  FROM
       GV$SESSION S,
       GV$SESS_IO I,
       V$PROCESS P
 WHERE
       S.SID = I.SID
	AND S.INST_ID=I.INST_ID   
   AND S.USER# = 0
   AND S.PADDR = P.ADDR
   AND (S.TYPE != 'USER' OR
        S.TERMINAL IS NOT NULL OR
        S.PROGRAM IS NOT NULL)
UNION
-- Snapshot refresh processes(also job queue processes)
SELECT rpad(p.username,8)||'/'||
       substr(p.program,instr(p.program,' ')) Usr,
       TO_CHAR(S.LOGON_TIME,'YYYY-MM-DD HH24:MI:SS') connected,
       S.Inst_id||':'||S.SID||','||S.SERIAL# Instance,substr(S.STATUS,1,1) STAT, p.spid server, s.process client,
       substr(p.program,instr(p.program,'@')+1,
              instr(p.program,' ')-instr(p.program,'@')) MACHINE,
       substr(S.MODULE,1,30) module
  FROM
       GV$SESSION S,
       GV$SESS_IO I, 
       V$PROCESS P
 WHERE
       S.SID = I.SID
   AND S.INST_ID=I.INST_ID	   
   AND S.USER# = 0
   AND S.TYPE = 'USER'
   AND S.TERMINAL IS NULL
   AND S.PROGRAM IS NULL
   AND S.PADDR = P.ADDR
UNION
-- Users
SELECT rpad(S.OSUSER,8)||'/'||rpad(S.USERNAME,8) Usr,
       TO_CHAR(S.LOGON_TIME,'YYYY-MM-DD HH24:MI:SS') connected,
       S.Inst_id||':'||S.SID||','||S.SERIAL# Instance,substr(S.STATUS,1,1) STAT, p.spid server, s.process client,
       substr(S.MACHINE,1,20) MACHINE, substr(S.MODULE,1,30) module
  FROM
       GV$SESSION S,
       GV$SESS_IO I,
       V$PROCESS P
 WHERE
       S.SID = I.SID
    AND S.INST_ID=I.INST_ID	 	   
   AND S.USER# != 0
   AND S.PADDR = P.ADDR
 ORDER BY  2,4;

col total_sess format 9999
col host_name format a15
col inst_name format a6
break on inst_name skip 1
select i.instance_name inst_name,i.host_name,s.status,count(*) total_sess from gv$session s,gv$instance i
where i.inst_id=s.inst_id
group by i.instance_name,i.host_name,s.status
order by 1,2;