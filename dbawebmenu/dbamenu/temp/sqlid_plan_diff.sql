
set markup html on

define sqlid=&1
define phv_1=&2
define phv_2=&3
set verify off
col PLAN_HASH_VALUE for 9999999999 heading 'Plan|Hash Value'
col OBJECT_OWNER for a15
col OBJECT_NAME for a35
col OBJECT_TYPE for a15
set linesize 100
set pagesize 0
select 'SQL PLAN DIFF  FROM PLAN '||&phv_1||' minus/to '||&phv_2 from dual;
set pagesize 100
select distinct SQL_ID,OBJECT_OWNER,OBJECT_NAME,OBJECT_TYPE from  DBA_HIST_SQL_PLAN  where SQL_ID='&&sqlid'
and PLAN_HASH_VALUE=&&phv_1
minus
select distinct SQL_ID,OBJECT_OWNER,OBJECT_NAME,OBJECT_TYPE from  DBA_HIST_SQL_PLAN  where SQL_ID='&&sqlid'
and PLAN_HASH_VALUE=&&phv_2
/
set pagesize 0
select 'SQL PLAN DIFF  FROM PLAN '||&phv_2||' minus/to '||&phv_1 from dual;
set pagesize 100
select distinct SQL_ID,OBJECT_OWNER,OBJECT_NAME,OBJECT_TYPE from  DBA_HIST_SQL_PLAN  where SQL_ID='&&sqlid'
and PLAN_HASH_VALUE=&&phv_2
minus
select distinct SQL_ID,OBJECT_OWNER,OBJECT_NAME,OBJECT_TYPE from  DBA_HIST_SQL_PLAN  where SQL_ID='&&sqlid'
and PLAN_HASH_VALUE=&&phv_1
/