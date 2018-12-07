set markup html on
SET TERMOUT OFF;
COLUMN current_instance NEW_VALUE current_instance NOPRINT;
COLUMN db_unique_name NEW_VALUE db_unique_name NOPRINT;
COLUMN current_timestamp NEW_VALUE current_timestamp  NOPRINT;
SELECT rpad(sys_context('USERENV', 'DB_UNIQUE_NAME'),15)  db_unique_name  FROM DUAL;
SELECT rpad(instance_name, 17) current_instance,rpad(to_char(current_timestamp,'DD-MON-YY HH24:MI'),17) current_timestamp FROM v$instance;
SET TERMOUT ON

PROMPT
PROMPT +------------------------------------------------------------------------+
PROMPT   Report   	: Show Active Sessions(User:&1)
PROMPT   DB_Name  	: &db_unique_name
PROMPT   Report Time	: &current_timestamp
PROMPT +------------------------------------------------------------------------+

set linesize 200
set pagesize 2000
clear columns
clear breaks
define input=&1
ttitle off

column usr                 format a25       Heading 'Osuser  /Prg'
#column sid                 format 9999      heading 'S|I|D'
column inst                format 999       heading 'Inst|ID'
column connected           format A19       heading 'Connected'
column stat                format A1        heading 'S|t|a|t'
#column serial              format 9999999   heading 'Serial#'
column machine             format A25       heading 'Machine'
column logical             format A19       heading '      Logical|    Gets / Chgs'
column physical_reads      format 999999999 heading 'Physical|Reads'
column chgs                format A9        heading 'Logical|  Chgs'
column consistent_changes  format 999999999 heading 'Consist|Changes'
column module              format A25       heading 'Module'
column service             format A20       heading 'Service'
col sess for a12 heading 'SID|Serial#'

set verify off
SELECT rpad(p.username,8)||'/'||
       rpad(p.program,15) Usr,
    --    substr(p.program,instr(p.program,' ')) Usr,
	s.inst_id inst,
	'('||s.sid||','||s.serial#||')' sess,
       --TO_CHAR(S.LOGON_TIME,'YYYY-MM-DD HH24:MI:SS') connected,
       substr(S.STATUS,1,1) STAT,
       substr(p.program,instr(p.program,'@')+1,
              instr(p.program,' ')-instr(p.program,'@')) MACHINE,
       lpad(to_char(I.BLOCK_GETS+I.CONSISTENT_GETS),9)||'/'||
       lpad(to_char(I.BLOCK_CHANGES+I.CONSISTENT_CHANGES),9) logical,
       I.PHYSICAL_READS, 
       substr(S.MODULE,1,25) module,
       substr(S.SERVICE_NAME,1,20) service,s.sql_id
  FROM
       GV$SESSION S,
       GV$SESS_IO I, 
       GV$PROCESS P
 WHERE
        S.INST_ID=I.INST_ID 
   AND  S.INST_ID=P.INST_ID 
   AND  S.SID = I.SID
   AND S.USER# = 0
   AND S.TYPE = 'USER'
   AND S.TERMINAL IS NULL
   AND S.PROGRAM IS NULL
   AND S.PADDR = P.ADDR AND S.STATUS='ACTIVE'
   AND (upper(s.username) like upper('%&input%'))
UNION
-- Users
SELECT rpad(S.OSUSER,8)||'/'||rpad(S.USERNAME,10) Usr,
	s.inst_id inst,
	 '('||s.sid||','||s.serial#||')' sess,
       --TO_CHAR(S.LOGON_TIME,'YYYY-MM-DD HH24:MI:SS') connected,
       substr(S.STATUS,1,1) STAT,
       substr(S.MACHINE,1,29) MACHINE,
       lpad(to_char(I.BLOCK_GETS+I.CONSISTENT_GETS),9)||'/'||
       lpad(to_char(I.BLOCK_CHANGES+I.CONSISTENT_CHANGES),9) logical,
       I.PHYSICAL_READS, 
       substr(S.MODULE,1,25) module,
	substr(S.SERVICE_NAME,1,20) service,s.sql_id
  FROM
       GV$SESSION S,
       GV$SESS_IO I
 WHERE
        S.INST_ID=I.INST_ID
   AND S.SID = I.SID
   AND S.USER# != 0  AND S.STATUS='ACTIVE'
   AND (upper(s.username) like upper('%&input%'))
 ORDER BY 2,3;