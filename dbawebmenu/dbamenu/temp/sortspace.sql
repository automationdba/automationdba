
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
PROMPT   Report   : TEMP space utilization detail
PROMPT   DB_Name  : &db_unique_name
PROMPT   Timestamp: &current_timestamp
PROMPT +------------------------------------------------------------------------+


prompt
prompt
set linesize 200
set pagesize 100
col total_mb format 999,999.9
col used_mb  format 999,999.9
col free_mb  format 999,999.9
col free_prcnt format 999.9 heading '%free'
col inst_id  format 99

prompt +------------------------+
prompt  TOTAL Temp Space Usage...
prompt +------------------------+
select vs.inst_id,vs.TABLESPACE_NAME
      ,t3.maxsize total_mb
      ,vs.USED_BLOCKS*t2.block_size_kb/1024 used_mb
      ,(t3.maxsize-(vs.USED_BLOCKS*t2.block_size_kb/1024)) free_mb
	,round(100*(t3.maxsize-(vs.USED_BLOCKS*t2.block_size_kb/1024))/t3.maxsize,2) free_prcnt
  from gv$sort_segment vs
     , (select value/1024 block_size_kb from v$parameter where name = 'db_block_size') t2
     , (select d.tablespace_name, sum(bytes/1024/1024) maxsize
          from dba_temp_files d
         group by d.tablespace_name) t3
  where vs.tablespace_name = t3.tablespace_name
        order by 1,2;
--
--      Sort Space Usage by Session
--
prompt +----------------------------+
prompt  Sort space usage by session
prompt +----------------------------+
set linesize 200
set pagesize 200
col SID_SERIAL for a13 heading "SID,SERIAL#"
col spid for a6
col inst_id for 999 heading "Inst|ID"
col username for a15
col OSUSER for a9
col module for a20
col program for a20
col tablespace for a15
SELECT   S.inst_id,S.sid || ',' || S.serial# sid_serial, S.username, S.osuser, P.spid, S.module,
         S.program, SUM (T.blocks) * TBS.block_size / 1024 / 1024 mb_used, T.tablespace,
         COUNT(*) sort_ops
FROM     gv$sort_usage T, gv$session S, dba_tablespaces TBS, gv$process P
WHERE    T.session_addr = S.saddr
AND      S.paddr = P.addr
AND      T.tablespace = TBS.tablespace_name
AND      S.inst_id=t.inst_id
AND      p.inst_id=s.inst_id
GROUP BY s.inst_id,S.sid, S.serial#, S.username, S.osuser, P.spid, S.module,
         S.program, TBS.block_size, T.tablespace
ORDER BY s.inst_id,S.sid,S.serial#;
--
--      Sort Space Usage by Statement
--
prompt +-------------------------------+
prompt  Sort space usage by statement
prompt +-------------------------------+
col sql_text for a65
SELECT   t.inst_id,S.sid || ',' || S.serial# sid_serial, S.username,
         T.blocks * TBS.block_size / 1024 / 1024 mb_used, T.tablespace,
         Q.sql_id sql_id, Q.hash_value, Q.sql_text
FROM     gv$sort_usage T, gv$session S,gv$sqlarea Q, dba_tablespaces TBS
WHERE  t.inst_id=s.inst_id and s.inst_id=q.inst_id  
AND    S.sql_id=Q.sql_id
AND    S.sql_id=T.sql_id
AND 	T.session_addr = S.saddr
AND      T.sqladdr = Q.address (+)
AND      T.tablespace = TBS.tablespace_name
ORDER BY S.sid;