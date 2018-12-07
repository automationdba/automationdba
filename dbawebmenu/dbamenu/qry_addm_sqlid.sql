set markup html on

define sqlid=&1




SET TERMOUT OFF;
COLUMN current_instance NEW_VALUE current_instance NOPRINT;
COLUMN db_unique_name NEW_VALUE db_unique_name NOPRINT;
COLUMN current_timestamp NEW_VALUE current_timestamp  NOPRINT;
SELECT rpad(sys_context('USERENV', 'DB_UNIQUE_NAME'),15)  db_unique_name  FROM DUAL;
SELECT rpad(instance_name, 17) current_instance,rpad(to_char(current_timestamp,'DD-MON-YY HH24:MI'),17) current_timestamp FROM v$instance;
SET TERMOUT ON

PROMPT
PROMPT +-------------------------------------------------------------------------+
PROMPT   Report   :  Last 7 Days ADDM Finding for Query(&sqlid)
PROMPT   DB_Name  : &db_unique_name 
PROMPT   Timestamp: &current_timestamp
PROMPT +-------------------------------------------------------------------------+
PROMPT
set verify off

Select distinct to_char(a.execution_end,'DD-MON-YY HH24:MI') execution_end, b.type, d.rank, d.type,
'Message           : '||b.message MESSAGE,
'Command To correct: '||c.command COMMAND,
'Action Message    : '||c.message ACTION_MESSAGE
From dba_advisor_tasks a, dba_advisor_findings b,
Dba_advisor_actions c, dba_advisor_recommendations d
Where a.owner=b.owner and a.task_id=b.task_id
And b.task_id=d.task_id and b.finding_id=d.finding_id
And a.task_id=c.task_id and d.rec_id=c.rec_Id
And a.task_name like 'ADDM%' and a.status='COMPLETED'
And a.EXECUTION_START > sysdate-7
And c.message like '%&sqlid%'
Order by execution_end,d.rank
/