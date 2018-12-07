set markup html on 
SET SQLBLANKLINES ON
set echo off;

-- ***************************************************
--   Customer-customizable report settings
--   Change these variables to run a report on different statistics
-- ***************************************************
-- The default number of days of snapshots to list when displaying the
-- list of snapshots to choose the begin and end snapshot Ids from.
--

-- dbid setup
column dbid new_value v_dbid
select distinct dbid  from dba_hist_database_instance where startup_time=(select max(startup_time) from dba_hist_database_instance);
define dbid = &v_dbid
define dbid2 = &v_dbid
----

-- inst_num
define inst_num = &1;
define inst_num2 = &4; 

--   List all snapshots
define num_days = 8;
define num_days2 = 8;
--
--   List no (i.e. 0) snapshots
-- define num_days = 0;
--
-- List past 3 day's snapshots
-- define num_days = 3;
--
-- Reports can be printed in text or html, and you must set the report_type
-- in addition to the report_name
--
-- Issue Report in Text Format
-- define report_type='text';
--
-- Issue Report in HTML Format
define report_type='html';

-- Optionally, set the snapshots for the report.  If you do not set them,
-- you will be prompted for the values.

variable dbid number;
variable dbid2 number;
variable bid number;
variable bid2 number;
variable eid number;
variable eid2 number;
variable inst_num number;
variable inst_num2 number;

define begin_snap=&2;
define end_snap =&3;
define begin_snap2=&5;
define end_snap2 =&6;

-- dbid setup


begin
  :dbid := &dbid;
  :dbid2 := &dbid;
  :inst_num := &inst_num;
  :inst_num2 := &inst_num2;
  :bid := &begin_snap;
  :eid := &end_snap;
  :bid2 := &begin_snap2;
  :eid := &end_snap2;
end;
/


-- Optionally, set the name for the report itself
--define report_name = '/tmp/awrrpt_1_545_546.html'
define report_name = '&7';

-- ***************************************************
--   End customer-customizable settings
-- ***************************************************


-- *******************************************************
--  The report_options variable will be the options for
--  the AWR report.
--
--  Currently, only one option is available.
--
--  NO_OPTIONS -
--    No options. Setting this will not show the ADDM
--    specific portions of the report.
--    This is the default setting.
--
--  ENABLE_ADDM -
--    Show the ADDM specific portions of the report.
--    These sections include the Buffer Pool Advice,
--    Shared Pool Advice, PGA Target Advice, and
--    Wait Class sections.
--

set veri off;
set feedback off;

variable rpt_options number;

-- option settings
define NO_OPTIONS   = 0;
define ENABLE_ADDM  = 8;

-- set the report_options. To see the ADDM sections,
-- set the rpt_options to the ENABLE_ADDM constant.
begin
  :rpt_options := &NO_OPTIONS;
end;
/

--
-- Find out if we are going to print report to html or to text
prompt
prompt Specify the Report Type
prompt ~~~~~~~~~~~~~~~~~~~~~~~
prompt Would you like an HTML report, or a plain text report?
prompt Enter 'html' for an HTML report, or 'text' for plain text
prompt  Defaults to 'html'

column report_type new_value report_type;
set heading off;
select 'Type Specified: ',lower(nvl('&&report_type','html')) report_type from dual;
set heading on;

set termout off;
-- Set the extension based on the report_type
column ext new_value ext;
select '.html' ext from dual where lower('&&report_type') <> 'text';
select '.txt' ext from dual where lower('&&report_type') = 'text';
set termout on;

define report_type='html'
-- Get the common input!
-- awrinput will set up the bind variables we need to call the PL/SQL procedure
@@awrddinp.sql 'awrdiff_' &&ext

set termout off;
-- set report function name and line size
column fn_name new_value fn_name noprint;
select 'awr_diff_report_text' fn_name from dual where lower('&report_type') = 'text';
select 'awr_diff_report_html' fn_name from dual where lower('&report_type') <> 'text';

column lnsz new_value lnsz noprint;
select '320' lnsz from dual where lower('&report_type') = 'text';
select '1500' lnsz from dual where lower('&report_type') <> 'text';

set linesize &lnsz;
set termout on;
spool &report_name;
prompt

select 'WARNING: timed_statistics setting changed between begin/end snaps: TIMINGS ARE INVALID'
  from dual
 where not exists
      (select null
         from dba_hist_parameter b
            , dba_hist_parameter e
        where b.snap_id         = :bid
          and e.snap_id         = :eid
          and b.dbid            = :dbid
          and e.dbid            = :dbid
          and b.instance_number = :inst_num
          and e.instance_number = :inst_num
          and b.parameter_hash  = e.parameter_hash
          and b.parameter_name = 'timed_statistics'
          and b.value           = e.value)
 or not exists
      (select null
         from dba_hist_parameter b
            , dba_hist_parameter e
        where b.snap_id         = :bid2
          and e.snap_id         = :eid2
          and b.dbid            = :dbid2
          and e.dbid            = :dbid2
          and b.instance_number = :inst_num2
          and e.instance_number = :inst_num2
          and b.parameter_hash  = e.parameter_hash
          and b.parameter_name = 'timed_statistics'
          and b.value           = e.value);

select output from table(dbms_workload_repository.&fn_name( :dbid,
                                                            :inst_num,
                                                            :bid, :eid,
                                                            :dbid2,
                                                            :inst_num2,
                                                            :bid2, :eid2
                                                           ));

spool off;

prompt Report written to &report_name.

set termout off;
clear columns sql;
ttitle off;
btitle off;
repfooter off;
set linesize 78 termout on feedback 6 heading on;
-- Undefine report name (created in awrinput.sql)
undefine report_name

undefine report_type
undefine ext
undefine fn_name
undefine lnsz

undefine NO_OPTIONS
undefine ENABLE_ADDM

undefine top_n_events
undefine num_days
undefine top_n_sql
undefine top_pct_sql
undefine sh_mem_threshold
undefine top_n_segstat

whenever sqlerror continue;
--
--  End of script file;
