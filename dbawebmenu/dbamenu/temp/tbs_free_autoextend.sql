set markup html on
SET TERMOUT OFF;
COLUMN current_instance NEW_VALUE current_instance NOPRINT;
COLUMN db_unique_name NEW_VALUE db_unique_name NOPRINT;
COLUMN current_timestamp NEW_VALUE current_timestamp  NOPRINT;
SELECT rpad(sys_context('USERENV', 'DB_UNIQUE_NAME'),15)  db_unique_name  FROM DUAL;
SELECT rpad(instance_name, 17) current_instance,rpad(to_char(current_timestamp,'DD-MON-YY HH24:MI'),17) current_timestamp FROM v$instance;
SET TERMOUT ON

PROMPT
PROMPT +------------------------------------------+
PROMPT   Report   : Tablespace Free Space Detail
PROMPT   DB_Name  : &db_unique_name
PROMPT   Timestamp: &current_timestamp
PROMPT +------------------------------------------+


REM Tablespace with autoextend 
REM REQUIRES:   dba_tablespaces, dba_data_files
REM
undefine tbs
define tbs=&1
COLUMN tbs NEW_VALUE tbs NOPRINT;
SET lines 140 pages 66 feedback off
COLUMN tablespace_name        format a25             heading 'Tablespace|(TBS)|Name'
COLUMN autoextensible         format a6              heading 'Can|Auto|Extend'
COLUMN files_in_tablespace    format 999             heading 'Files|In|TBS'
COLUMN total_tablespace_space format 99,999,999,999 heading 'Total|CurrentMB|TBS|Space'
COLUMN total_used_space       format 99,999,999,999 heading 'Total|CurrentMB|Used|Space'
COLUMN total_tablespace_free_space format 99,999,999,999 heading 'Total|CurrentMB|Free|Space'
COLUMN total_used_pct              format 999.99      heading 'Total|Current|UsedMB|(%)'
COLUMN pct_used_max              format 999.99      heading 'Max|Used|(%)'
COLUMN total_free_pct              format 999.99      heading 'Total|Current|FreeMB|(%)'
COLUMN max_size_of_tablespace      format 99,999,999 heading 'TBS|Max|SizeMB'
--COLUMN total_auto_used_pct         format 999.99      heading 'Total|Max|Used|(%)'
COLUMN total_auto_used_pct         format 999.99      heading 'Total|Max|Free|(%)'
--COLUMN total_auto_free_pct         format 999.99      heading 'Total|Max|Free|(%)'
COLUMN total_auto_free_pct         format 999.99      heading 'Total|Max|Used|(%)'
SET VERIFY OFF

SET TERMOUT ON
TTITLE left _date center Tablespace_Space_Utilization_Status_Report skip 2

WITH tbs_auto AS
     (SELECT DISTINCT tablespace_name, autoextensible
                 FROM dba_data_files 
                WHERE autoextensible = 'YES' and tablespace_name='&&tbs'),
     files AS
     (SELECT   tablespace_name, COUNT (*) tbs_files,
               SUM (BYTES/1024/1024) total_tbs_bytes
          FROM dba_data_files where tablespace_name='&&tbs'
      GROUP BY tablespace_name),
     fragments AS
     (SELECT   tablespace_name, COUNT (*) tbs_fragments,
               SUM (BYTES/1024/1024) total_tbs_free_bytes,
               MAX (BYTES/1024/1024) max_free_chunk_bytes
          FROM dba_free_space where tablespace_name='&&tbs'
      GROUP BY tablespace_name),
     AUTOEXTEND AS
     (SELECT   tablespace_name, SUM (size_to_grow) total_growth_tbs
          FROM (SELECT   tablespace_name, SUM (maxbytes/1024/1024) size_to_grow
                    FROM dba_data_files
                   WHERE autoextensible = 'YES' and tablespace_name='&&tbs'
                GROUP BY tablespace_name
                UNION
                SELECT   tablespace_name, SUM (BYTES/1024/1024) size_to_grow
                    FROM dba_data_files
                   WHERE autoextensible = 'NO' AND tablespace_name='&&tbs'
                GROUP BY tablespace_name)
      GROUP BY tablespace_name)
SELECT a.tablespace_name,
       CASE tbs_auto.autoextensible
          WHEN 'YES'
             THEN 'YES'
          ELSE 'NO'
       END AS autoextensible,
       files.tbs_files files_in_tablespace,
       files.total_tbs_bytes total_tablespace_space,
       (files.total_tbs_bytes - fragments.total_tbs_free_bytes
       ) total_used_space,
       fragments.total_tbs_free_bytes total_tablespace_free_space,
       (  (  (files.total_tbs_bytes - fragments.total_tbs_free_bytes)
           / files.total_tbs_bytes
          )
        * 100
       ) total_used_pct,
       ((fragments.total_tbs_free_bytes / files.total_tbs_bytes) * 100
       ) total_free_pct,
       AUTOEXTEND.total_growth_tbs max_size_of_tablespace
      ,(files.total_tbs_bytes - fragments.total_tbs_free_bytes
       )*100/AUTOEXTEND.total_growth_tbs pct_used_max
      , round(fragments.total_tbs_free_bytes/1024) free_max_gb
 /*       (  (  (  AUTOEXTEND.total_growth_tbs
              - (AUTOEXTEND.total_growth_tbs - fragments.total_tbs_free_bytes
                )
             )
           / AUTOEXTEND.total_growth_tbs
          )
        * 100
       ) total_auto_used_pct */
/*
       (  (  (AUTOEXTEND.total_growth_tbs - fragments.total_tbs_free_bytes)
           / AUTOEXTEND.total_growth_tbs
          )
        * 100
       ) total_auto_free_pct */ 
  FROM dba_tablespaces a, files, fragments, AUTOEXTEND, tbs_auto
 WHERE a.tablespace_name = files.tablespace_name
   AND a.tablespace_name = fragments.tablespace_name
   AND a.tablespace_name = AUTOEXTEND.tablespace_name
   AND a.tablespace_name = tbs_auto.tablespace_name(+)
   AND a.tablespace_name  = '&&tbs';
---

column name format a15
column variance format a20
column alloc_size_gb format 99999.9 heading 'Alloc_Size|GB'
column prev_used_size_gb format 99999.9 heading 'Prev_Used|Size GB'
column curr_used_size_gb format 99999.9 heading 'Used_Size|GB'
alter session set nls_date_format='yyyy-mm-dd';
with t as (
select ss.run_time,ts.name,round(su.tablespace_size*dt.block_size/1024/1024/1024,2) alloc_size_gb,
round(su.tablespace_usedsize*dt.block_size/1024/1024/1024,2) used_size_gb
from
dba_hist_tbspc_space_usage su,
(select trunc(BEGIN_INTERVAL_TIME) run_time,max(snap_id) snap_id from dba_hist_snapshot
group by trunc(BEGIN_INTERVAL_TIME) ) ss,
v$tablespace ts,
dba_tablespaces dt
where su.snap_id = ss.snap_id
and   su.tablespace_id = ts.ts#
and   ts.name          =upper('&&tbs')
and   ts.name          = dt.tablespace_name )
select e.run_time,e.name,e.alloc_size_gb,e.used_size_gb curr_used_size_gb,b.used_size_gb prev_used_size_gb,
case when e.used_size_gb > b.used_size_gb then to_char(e.used_size_gb - b.used_size_gb)
     when e.used_size_gb = b.used_size_gb then '***NO DATA GROWTH'
     when e.used_size_gb < b.used_size_gb then '******DATA PURGED' end variance
from t e, t b
where e.run_time = b.run_time + 1
order by 1;
---
TTITLE OFF
PROMPT
PROMPT +---------------------------+
PROMPT | Datafiles of Tablespace                                                |
PROMPT +---------------------------+
COLUMN size_mb format 99,999,999 heading 'Total|UsedMB'
COLUMN max_mb format 99,999,999 heading 'Total|MaxMB'
col auto_exnd for a5 heading 'Auto|Extnd'
col file_name format a70
select file_id,file_name,maxbytes/1024/1024 max_mb, bytes/1024/1024 size_mb,autoextensible  auto_exnd from dba_data_files
where tablespace_name='&&tbs'
order by 1;

SET TERMOUT OFF;
COLUMN current_instance NEW_VALUE current_instance NOPRINT;
COLUMN hostname NEW_VALUE hostname;
SELECT rpad(sys_context('USERENV', 'INSTANCE_NAME'), 17) current_instance,sys_context('USERENV', 'SERVER_HOST') hostname FROM dual;
SET TERMOUT ON;

PROMPT
PROMPT +--------------------------------+
PROMPT   Report   : ASM Disk Group                                               
PROMPT   Instance : &current_instance                                            
PROMPT   Host	   : &hostname                                                    
PROMPT +--------------------------------+

SET ECHO        OFF
SET FEEDBACK    6
SET HEADING     ON
SET LINESIZE    180
SET PAGESIZE    50000
SET TERMOUT     ON
SET TIMING      OFF
SET TRIMOUT     ON
SET TRIMSPOOL   ON
SET VERIFY      OFF

--CLEAR COLUMNS
--CLEAR BREAKS
CLEAR COMPUTES

COLUMN group_name             FORMAT a30           HEAD 'Disk Group|Name'
COLUMN sector_size            FORMAT 99,999        HEAD 'Sector|Size'
COLUMN block_size             FORMAT 99,999        HEAD 'Block|Size'
--COLUMN allocation_unit_size   FORMAT 999,999,999   HEAD 'Allocation|Unit Size'
COLUMN state                  FORMAT a11           HEAD 'State'
COLUMN type                   FORMAT a6            HEAD 'Type'
COLUMN total_gb               FORMAT 999,999,999   HEAD 'Total Size (GB)'
COLUMN used_gb                FORMAT 999,999,999   HEAD 'Used Size (GB)'
COLUMN free_gb                FORMAT 999,999,999   HEAD 'Free Size (GB)'
COLUMN pct_used               FORMAT 999.99        HEAD '(%)Used'

--BREAK ON report ON disk_group_name SKIP 1

--COMPUTE sum LABEL "Grand Total: " OF total_mb used_mb ON report

SELECT
    name                                     group_name
--  , sector_size                              sector_size
 , block_size                               block_size
 -- , allocation_unit_size                     allocation_unit_size
  , state                                    state
  , type                                     type
  , total_mb/1024                                 total_gb
  , (total_mb - free_mb)/1024                     used_gb
  , free_mb/1024                             free_gb
  , ROUND((1- (free_mb / total_mb))*100, 2)  pct_used
FROM
    v$asm_diskgroup
WHERE
    total_mb != 0 and upper(name) 
    in ( 
select distinct
case when instr(FILE_NAME,'/')>1
     then substr(FILE_NAME,2,instr(FILE_NAME,'/')-2)
     else FILE_NAME end
TBS_DG_NAME  from dba_data_files where tablespace_name='&&tbs')
/