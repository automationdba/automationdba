set markup html on
undefine inst_id
undefine sid

define inst_id=&1;
define sid=&2;

SET TERMOUT OFF;
COLUMN current_instance NEW_VALUE current_instance NOPRINT;
COLUMN db_unique_name NEW_VALUE db_unique_name NOPRINT;
COLUMN current_timestamp NEW_VALUE current_timestamp  NOPRINT;
SELECT rpad(sys_context('USERENV', 'DB_UNIQUE_NAME'),15)  db_unique_name  FROM DUAL;
SELECT rpad(instance_name, 17) current_instance,rpad(to_char(current_timestamp,'DD-MON-YY HH24:MI'),17) current_timestamp FROM v$instance;
SET TERMOUT ON

PROMPT
PROMPT +----------------------------------------------------------+
PROMPT   Report   : Session Details(Ins: &inst_id,SID:&sid )  
PROMPT   DB_Name  : &db_unique_name 
PROMPT   Timestamp: &current_timestamp
PROMPT +----------------------------------------------------------+

--Get specific session details(RAC) include wait,sort,undo details
col inst format 999
col sid format 9999
col sql_id format a15
col username format a10
col osuser format a10
col program format a25
col process format 9999999
col spid format 999999
col logon_time format a13


define inst_id=&1;
define sid=&2;

set heading off
set verify off
set feedback off

col sid NEW_VALUE sid noprint
col inst_id NEW_VALUE inst_id noprint
col spid NEW_VALUE spid noprint

 
         SELECT  s.inst_id inst_id,s.sid sid,p.spid
         FROM gv$session s,
              gv$process p 
         WHERE s.inst_id = p.inst_id
         AND s.sid=&sid
	 AND s.inst_id=&inst_id
         AND s.paddr = p.addr 
         ORDER BY s.inst_id,s.sid;

col sid NEW_VALUE sid print
col sql_id NEW_VALUE sid print
col inst_id NEW_VALUE inst_id print

PROMPT Session and Process Information
PROMPT -------------------------------

col event for a30

select 'Instance                        : '||v.inst_id  || chr(10)|| 
                '    SID                        : '||v.sid      || chr(10)|| 
                '    SQL ID                     : '||v.sql_id      || chr(10)|| 
       '    Serial Number               : '||v.serial#  || chr(10) ||
       '    Oracle User Name            : '||v.username         || chr(10) ||
       '    Client OS user name         : '||v.osuser   || chr(10) ||
       '    Client Process ID           : '||v.process  || chr(10) ||
       '    Client machine Name         : '||v.machine  || chr(10) ||
       '    Oracle PID                  : '||p.pid      || chr(10) ||
       '    OS Process ID(spid)         : '||p.spid     || chr(10) ||
       '    Session''s Status           : '||v.status   || chr(10) ||
       '    Logon Time                  : '||to_char(v.logon_time, 'MM/DD HH24:MIpm')   || chr(10) ||
       '    Program Name                : '||v.program  || chr(10) 
from gv$session v, gv$process p
where v.inst_id = p.inst_id
and v.paddr = p.addr
and v.serial# > 1
and p.background is null
and p.username is not null
and sid = &sid
and v.inst_id=&inst_id
order by logon_time, v.status, 1
/
set heading on
col host for a20
col inst_name for a8 heading "Inst|Name"

col host_name for a25
select  distinct a.inst_id inst,a.sql_id sqlid,a.hash_value hash,a.address addr,c.instance_name inst_name,c.host_name host,c.instance_role inst_role
from gv$sql a,gv$session b,gv$instance c
where b.inst_id = c.inst_id
and a.address = b.sql_address
and b.inst_id = &inst_id
and b.sid = &sid
order by a.inst_id;

PROMPT
PROMPT SQL STATEMENT
PROMPT -------------


col sql_text for a180
set linesize 200
set pagesize 250
select  a.sql_text
from gv$sqltext a, gv$session b
where a.inst_id=b.inst_id
and a.address = b.sql_address
and b.inst_id=&inst_id
and b.sid = &sid
order by b.inst_id,a.piece;

set heading off

PROMPT
PROMPT Event Wait Information
PROMPT ----------------------

select '   SID '|| &sid ||' is waiting on event : ' || x.event || chr(10) ||
       '   P1 Text                      : ' || x.p1text || chr(10) ||
       '   P1 Value                     : ' || x.p1 || chr(10) ||
       '   P2 Text                      : ' || x.p2text || chr(10) ||
       '   P2 Value                     : ' || x.p2 || chr(10) ||
       '   P3 Text                      : ' || x.p3text || chr(10) ||
       '   P3 Value                     : ' || x.p3  || chr(10) ||
       '   State                        : ' || x.state  || chr(10) ||
       '   second_in_wait               : ' || x.seconds_in_wait
from gv$session_wait x
where x.inst_id  = &inst_id
and x.sid= &sid;

set heading on
PROMPT
PROMPT Session Long Operation
PROMPT ----------------------

-- session long operation more than 30 minutes
set linesize 160
set pagesize 120
column Inst_id                 format 999      heading 'Inst|Id'
column sid                 format 9999      heading 'SID'
column serial              format 9999999   heading 'Serial#'
column elapsed_seconds format 999999 heading 'Elapsed|seconds'
column time_remaining format 999999 heading 'time|remaining'
column start_time format a19
column username format a10
column message format a60
select inst_id,sid,serial#,username,message,to_char(start_time,'dd-mon-yy hh24:mi:ss') start_time,elapsed_seconds,time_remaining from gv$session_longops
where elapsed_seconds > 180 and inst_id=&inst_id and sid=&sid
order by elapsed_seconds desc
/
set heading on