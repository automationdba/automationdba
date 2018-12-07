set markup html on

set linesize 200
--set term off
set pagesize 2000
set long 20000
set verify off
define sql_id='&1'
col SQL_FULLTEXT format A200
prompt
prompt +------------------------------------------+
prompt SQL Text of &sql_id from Cursor Cache
prompt +------------------------------------------+
prompt
select SQL_FULLTEXT from v$sqlarea where sql_id='&sql_id';
prompt 
prompt +------------------------------------------+
prompt  SQL Text of &sql_id from History
prompt +------------------------------------------+
prompt
select sql_text from DBA_HIST_SQLTEXT where  sql_id='&sql_id';