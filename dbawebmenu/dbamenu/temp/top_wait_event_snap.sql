set markup html on
SET TERMOUT OFF;
COLUMN current_instance NEW_VALUE current_instance NOPRINT;
COLUMN db_unique_name NEW_VALUE db_unique_name NOPRINT;
COLUMN current_timestamp NEW_VALUE current_timestamp  NOPRINT;
SELECT rpad(sys_context('USERENV', 'DB_UNIQUE_NAME'),15)  db_unique_name  FROM DUAL;
SELECT rpad(instance_name, 17) current_instance,rpad(to_char(current_timestamp,'DD-MON-YY HH24:MI'),17) current_timestamp FROM v$instance;
SET TERMOUT ON
SET VERIFY      OFF

set linesize 160
set pagesize 40
--clear columns
--clear breaks
define start_time=&1
define end_time=&2
ttitle off

PROMPT
PROMPT +------------------------------------------------------------------------+
PROMPT   Report   : Show Top Wait event hist
PROMPT   DB_Name  : &db_unique_name
--PROMPT   Timestamp: &current_timestamp
PROMPT   Start Snap : &start_time
PROMPT   End   Snap : &end_time
PROMPT +------------------------------------------------------------------------+

set linesize 200
column BEGIN_INTERVAL_TIME for a26
col event_name for a40
col instance_number for 999 heading 'Ins'
col event_time_waited for 9999999.99
col total_time_waited for 9999999.99
col total_waits for 9999999.99
col pct for 999.9
--select Day, Event_name, Total_wait from (
--select day, event_name, sum(event_time_waited) total_wait,
--row_number() over (partition by day order by sum(event_time_waited) desc) rn from (
SELECT   to_date(to_char(begin_interval_time,'dd/mm/yyyy:hh24:mi'),'dd/mm/yyyy:hh24:mi') day,s.begin_interval_time, m.*
    FROM (SELECT ee.instance_number, ee.snap_id, ee.event_name,
                 ROUND (ee.event_time_waited / 1000000) event_time_waited,
                 ee.total_waits,
                 ROUND ((ee.event_time_waited * 100) / et.total_time_waited,
                        1
                       ) pct,
                 ROUND ((ee.event_time_waited / ee.total_waits) / 1000
                       ) avg_wait
            FROM (SELECT ee1.instance_number, ee1.snap_id, ee1.event_name,
                           ee1.time_waited_micro - ee2.time_waited_micro event_time_waited,
                         ee1.total_waits - ee2.total_waits total_waits
                    FROM dba_hist_system_event ee1 JOIN dba_hist_system_event ee2
                         ON ee1.snap_id = ee2.snap_id + 1
                       AND ee1.instance_number = ee2.instance_number
                       AND ee1.event_id = ee2.event_id
                       AND ee1.wait_class_id <> 2723168908
                       AND ee1.time_waited_micro - ee2.time_waited_micro > 0
                  UNION
                  SELECT st1.instance_number, st1.snap_id,
                         st1.stat_name event_name,
                         st1.VALUE - st2.VALUE event_time_waited,
                         1 total_waits
                    FROM dba_hist_sys_time_model st1 JOIN dba_hist_sys_time_model st2
                         ON st1.instance_number = st2.instance_number
                       AND st1.snap_id = st2.snap_id + 1
                       AND st1.stat_id = st2.stat_id
                       AND st1.stat_name = 'DB CPU'
                       AND st1.VALUE - st2.VALUE > 0
                         ) ee
                 JOIN
                 (SELECT et1.instance_number, et1.snap_id,
                         et1.VALUE - et2.VALUE total_time_waited
                    FROM dba_hist_sys_time_model et1 JOIN dba_hist_sys_time_model et2
                         ON et1.snap_id = et2.snap_id + 1
                       AND et1.instance_number = et2.instance_number
                       AND et1.stat_id = et2.stat_id
                       AND et1.stat_name = 'DB time'
                       AND et1.VALUE - et2.VALUE > 0
                         ) et
                 ON ee.instance_number = et.instance_number
               AND ee.snap_id = et.snap_id
                 ) m
         JOIN
         dba_hist_snapshot s ON m.snap_id = s.snap_id and s.snap_id between 
 (select max(snap_id) from DBA_HIST_SNAPSHOT where BEGIN_INTERVAL_TIME <= to_timestamp('&start_time','YYYY-MM-DD:HH24:MI'))
   and (select max(snap_id) from DBA_HIST_SNAPSHOT where END_INTERVAL_TIME <= to_timestamp('&end_time','YYYY-MM-DD:HH24:MI'))
 order by 2
--) group by day ,event_name
--order by day desc, total_wait desc
--)where rn < 6
/