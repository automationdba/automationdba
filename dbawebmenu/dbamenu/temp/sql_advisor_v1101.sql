
define sqlid = &1

define report_name = &2
 
Rem
Rem $Header: sqltrpt.sql 11-apr-2005.11:01:39 pbelknap Exp $
Rem
Rem sqltrpt.sql
Rem
Rem Copyright (c) 2004, 2005, Oracle. All rights reserved.  
Rem
Rem    NAME
Rem      sqltrpt.sql - SQL Tune RePorT
Rem
Rem    DESCRIPTION
Rem      Script that gets a single statement as input from the user (via SQLID),
Rem      tunes that statement, and then displays the text report.
Rem
Rem      To tune multiple statements, create a sql tuning set and create a
Rem      tuning task with it as input (see dbmssqlt.sql).
Rem
Rem    NOTES
Rem      <other useful comments, qualifications, etc.>
Rem
Rem    MODIFIED   (MM/DD/YY)
Rem    pbelknap    04/11/05 - remove linesize 
Rem    kyagoub     07/05/04 - kyagoub_proj_13448-2
Rem    pbelknap    06/29/04 - feedback from rae burns 
Rem    pbelknap    06/17/04 - Created
Rem

SET NUMWIDTH 10
SET TAB OFF

--spool sql_advisor_v1101_test.lst
spool '&report_name' 
set long 1000000;
set longchunksize 1000;
set feedback off;
set veri off;

-- Get the sql statement to tune

prompt
prompt Tune the sql
prompt ~~~~~~~~~~~~
variable task_name varchar2(64);
variable err       number;

-- By default, no error
execute :err := 0;

#define sqlid=&1
set serveroutput on;

DECLARE
  cnt      NUMBER;
  bid      NUMBER;
  eid      NUMBER;
BEGIN
  -- If it's not in V$SQL we will have to query the workload repository
  select count(*) into cnt from V$SQLSTATS where sql_id = '&&sqlid';

  IF (cnt > 0) THEN
    :task_name := dbms_sqltune.create_tuning_task(sql_id => '&&sqlid');
  ELSE
    select min(snap_id) into bid
    from   dba_hist_sqlstat
    where  sql_id = '&&sqlid';

    select max(snap_id) into eid
    from   dba_hist_sqlstat
    where  sql_id = '&&sqlid';

    :task_name := dbms_sqltune.create_tuning_task(begin_snap => bid,
                                                  end_snap => eid,
                                                  sql_id => '&&sqlid');
  END IF;

  dbms_sqltune.execute_tuning_task(:task_name);

EXCEPTION
  WHEN OTHERS THEN
    :err := 1;

    IF (SQLCODE = -13780) THEN
      dbms_output.put_line ('ERROR: statement is not in the cursor cache ' ||
                            'or the workload repository.');
      dbms_output.put_line('Execute the statement and try again');
    ELSE
      RAISE;
    END IF;   
 
END;
/

set heading off;
select dbms_sqltune.report_tuning_task(:task_name) from dual where :err <> 1;
select '   ' from dual where :err = 1;
set heading on;

undefine sqlid;
set feedback on;
set veri on;
spool off