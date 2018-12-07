
set markup html on
SET TERMOUT OFF;
COLUMN current_instance NEW_VALUE current_instance NOPRINT;
COLUMN db_unique_name NEW_VALUE db_unique_name NOPRINT;
COLUMN current_timestamp NEW_VALUE current_timestamp  NOPRINT;
SELECT rpad(sys_context('USERENV', 'DB_UNIQUE_NAME'),15)  db_unique_name  FROM DUAL;
SELECT rpad(instance_name, 17) current_instance,rpad(current_timestamp,22) current_timestamp FROM v$instance;
SET TERMOUT ON

PROMPT
PROMPT +------------------------------------------------------------------------+
PROMPT | Report   : Long Active/Inactive Transactions                           |
PROMPT | DB_Name  : &db_unique_name                                             |
PROMPT | Timestamp: &current_timestamp                                          |
PROMPT +------------------------------------------------------------------------+


-- Connect to source database
set lines 300
set heading on
column username  for a25
column inst_id for 9999 heading 'Inst'
column transaction_duration  format a41
with transaction_details as
( select inst_id
  , ses_addr
  , sysdate - start_date as diff
  from gv$transaction
)
select s.username
, to_char(trunc(t.diff))
             || ' days, '
             || to_char(trunc(mod(t.diff * 24,24)))
             || ' hours, '
             || to_char(trunc(mod(t.diff * 24 * 60,24)))
             || ' minutes, '
             || to_char(trunc(mod(t.diff * 24 * 60 * 60,60)))
             || ' seconds' as transaction_duration
, s.program
, s.status
, s.inst_id
, s.sid
, s.serial#
from gv$session s
, transaction_details t
where s.inst_id = t.inst_id
and s.saddr = t.ses_addr
order by t.diff desc;
 