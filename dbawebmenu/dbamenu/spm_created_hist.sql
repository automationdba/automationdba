set markup html on
define sqlid=&1



SET TERMOUT OFF;
COLUMN current_instance NEW_VALUE current_instance NOPRINT;
COLUMN db_unique_name NEW_VALUE db_unique_name NOPRINT;
COLUMN current_timestamp NEW_VALUE current_timestamp  NOPRINT;
SELECT rpad(sys_context('USERENV', 'DB_UNIQUE_NAME'),15)  db_unique_name  FROM DUAL;
SELECT rpad(instance_name, 17) current_instance,rpad(current_timestamp,22) current_timestamp FROM v$instance;
SET TERMOUT ON

PROMPT
PROMPT +------------------------------------------------------------------------+
PROMPT | Report   : Check SPM Created History Status in Dict Table for &sqlid   |
PROMPT | DB_Name  : &db_unique_name                                             |
PROMPT | Timestamp: &current_timestamp                                          |
PROMPT +------------------------------------------------------------------------+


set verify off
set feed off
col sql_handle for a20
col PLAN_NAME for a30
WITH HX AS
     (SELECT distinct
      SQL_ID,
      (SELECT DBMS_SQLTUNE.SQLTEXT_TO_SIGNATURE(HT.SQL_TEXT) FROM DUAL) SIG
      FROM
      DBA_HIST_SQLTEXT HT
     )
SELECT SQL_ID,SQL_HANDLE,PLAN_NAME,ENABLED,ACCEPTED,FIXED,ORIGIN
FROM  DBA_SQL_PLAN_BASELINES B, HX
WHERE HX.SIG=B.SIGNATURE
AND ORIGIN='MANUAL-LOAD'
AND SQL_ID='&&sqlid'
/
