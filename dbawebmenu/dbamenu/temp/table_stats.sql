set markup html on
define owner=&1;
define table_name=&2;
col owner NEW_VALUE owner noprint
col table_name NEW_VALUE table_name noprint


col instance_id heading 'INS'
col user_id for a10
col host_id for a10
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
PROMPT | Report   : Table stats details(table name  - &table_name)              |
PROMPT | DB_Name  : &db_unique_name                                             |
PROMPT | Timestamp: &current_timestamp                                          |
PROMPT +------------------------------------------------------------------------+



set echo off
set scan on
set lines 160
set pages 66
set verify off
set feedback off
set termout off
column uservar new_value Table_Owner noprint
select user uservar from dual;
set termout on

prompt
--accept owner prompt 'Please enter Name of Table Owner: '
--accept table_name  prompt 'Please enter Table Name to show Statistics for: '
column TABLE_NAME heading "Table|Name" format a15
column PARTITION_NAME heading "Partition|Name" format a22
column SUBPARTITION_NAME heading "SubPartition|Name" format a15
column NUM_ROWS heading "Number|of Rows" format 999,999,990
column BLOCKS heading "Blocks" format 9,999,990
column EMPTY_BLOCKS heading "Empty|Blocks" format 999,990
column AVG_SPACE heading "Average|Space" format 9,990
column CHAIN_CNT heading "Chain|Count" format 990
column AVG_ROW_LEN heading "Average|Row Len" format 990
column COLUMN_NAME  heading "Column|Name" format a25
column NULLABLE heading Null|able format a4
column NUM_DISTINCT heading "Distinct|Values" format 999,990,000
column NUM_NULLS heading "Number|Nulls" format 99,990,000
column NUM_BUCKETS heading "Number|Buckets" format 990
column DENSITY heading "Density" format .999990
column INDEX_NAME heading "Index|Name" format a25
column UNIQUENESS heading "Unique" format a9
column BLEV heading "B|Tree|Level" format 90
column LEAF_BLOCKS heading "Leaf|Blks" format 9,990,000
column DISTINCT_KEYS heading "Distinct|Keys" format 999,999,990
column AVG_LEAF_BLOCKS_PER_KEY heading "Average|Leaf Blocks|Per Key" format 99,990
column AVG_DATA_BLOCKS_PER_KEY heading "Average|Data Blocks|Per Key" format 99,990
column CLUSTERING_FACTOR heading "Cluster|Factor" format 9,999,990
column COLUMN_POSITION heading "Col|Pos" format 990
column col heading "Column|Details" format a34
column COLUMN_LENGTH heading "Col|Len" format 990
column GLOBAL_STATS heading "Global|Stats" format a6
column USER_STATS heading "User|Stats" format a6
column SAMPLE_SIZE heading "Sample|Size" format 999,999,990
column to_char(t.last_analyzed,'MM-DD-YYYY') heading "Date|MM-DD-YYYY" format a10
prompt
prompt ***********
prompt Table Level
prompt ***********
prompt
select 
    TABLE_NAME,
    NUM_ROWS,
    BLOCKS,
    EMPTY_BLOCKS,
    AVG_SPACE,
    CHAIN_CNT,
    AVG_ROW_LEN,
    GLOBAL_STATS,
    USER_STATS,
    SAMPLE_SIZE,
    to_char(t.last_analyzed,'MM-DD-YYYY')
from dba_tables t
where 
    owner = upper(nvl('&&owner',user))
and table_name = upper('&&table_name')
/
select
    COLUMN_NAME,
    decode(t.DATA_TYPE,
           'NUMBER',t.DATA_TYPE||'('||
           decode(t.DATA_PRECISION,
                  null,t.DATA_LENGTH||')',
                  t.DATA_PRECISION||','||t.DATA_SCALE||')'),
                  'DATE',t.DATA_TYPE,
                  'LONG',t.DATA_TYPE,
                  'LONG RAW',t.DATA_TYPE,
                  'ROWID',t.DATA_TYPE,
                  'MLSLABEL',t.DATA_TYPE,
                  t.DATA_TYPE||'('||t.DATA_LENGTH||')') ||' '||
    decode(t.nullable,
              'N','NOT NULL',
              'n','NOT NULL',
              NULL) col,
    NUM_DISTINCT,
    DENSITY,
    NUM_BUCKETS,
    NUM_NULLS,
    GLOBAL_STATS,
    USER_STATS,
    SAMPLE_SIZE,
    to_char(t.last_analyzed,'MM-DD-YYYY')
from dba_tab_columns t
where 
    table_name = upper('&&table_name')
and owner = upper(nvl('&&owner',user))
/
select 
    INDEX_NAME,
    UNIQUENESS,
    BLEVEL BLev,
    LEAF_BLOCKS,
    DISTINCT_KEYS,
    NUM_ROWS,
    AVG_LEAF_BLOCKS_PER_KEY,
    AVG_DATA_BLOCKS_PER_KEY,
    CLUSTERING_FACTOR,
    GLOBAL_STATS,
    USER_STATS,
    SAMPLE_SIZE,
    to_char(t.last_analyzed,'MM-DD-YYYY') 
from 
    dba_indexes t
where 
    table_name = upper('&&table_name')
and table_owner = upper(nvl('&&owner',user))
/
break on index_name
select
    i.INDEX_NAME,
    i.COLUMN_NAME,
    i.COLUMN_POSITION,
    decode(t.DATA_TYPE,
           'NUMBER',t.DATA_TYPE||'('||
           decode(t.DATA_PRECISION,
                  null,t.DATA_LENGTH||')',
                  t.DATA_PRECISION||','||t.DATA_SCALE||')'),
                  'DATE',t.DATA_TYPE,
                  'LONG',t.DATA_TYPE,
                  'LONG RAW',t.DATA_TYPE,
                  'ROWID',t.DATA_TYPE,
                  'MLSLABEL',t.DATA_TYPE,
                  t.DATA_TYPE||'('||t.DATA_LENGTH||')') ||' '||
           decode(t.nullable,
                  'N','NOT NULL',
                  'n','NOT NULL',
                  NULL) col
from 
    dba_ind_columns i,
    dba_tab_columns t
where 
    i.table_name = upper('&&table_name')
and owner = upper(nvl('&&Owner',user))
and i.table_name = t.table_name
and i.column_name = t.column_name
order by index_name,column_position
/

prompt
prompt ***************
prompt Partition Level
prompt ***************

select
    PARTITION_NAME,
    NUM_ROWS,
    BLOCKS,
    EMPTY_BLOCKS,
    AVG_SPACE,
    CHAIN_CNT,
    AVG_ROW_LEN,
    GLOBAL_STATS,
    USER_STATS,
    SAMPLE_SIZE,
    to_char(t.last_analyzed,'MM-DD-YYYY')
from 
    dba_tab_partitions t
where 
    table_owner = upper(nvl('&&owner',user))
and table_name = upper('&&table_name')
order by partition_position
/


break on partition_name
select
    PARTITION_NAME,
    COLUMN_NAME,
    NUM_DISTINCT,
    DENSITY,
    NUM_BUCKETS,
    NUM_NULLS,
    GLOBAL_STATS,
    USER_STATS,
    SAMPLE_SIZE,
    to_char(t.last_analyzed,'MM-DD-YYYY')
from 
    dba_PART_COL_STATISTICS t
where 
    table_name = upper('&&table_name')
and owner = upper(nvl('&&owner',user))
/

break on partition_name
select 
    t.INDEX_NAME,
    t.PARTITION_NAME,
    t.BLEVEL BLev,
    t.LEAF_BLOCKS,
    t.DISTINCT_KEYS,
    t.NUM_ROWS,
    t.AVG_LEAF_BLOCKS_PER_KEY,
    t.AVG_DATA_BLOCKS_PER_KEY,
    t.CLUSTERING_FACTOR,
    t.GLOBAL_STATS,
    t.USER_STATS,
    t.SAMPLE_SIZE,
    to_char(t.last_analyzed,'MM-DD-YYYY')
from 
    dba_ind_partitions t, 
    dba_indexes i
where 
    i.table_name = upper('&&table_name')
and i.table_owner = upper(nvl('&&owner',user))
and i.owner = t.index_owner
and i.index_name=t.index_name
/


prompt
prompt ***************
prompt SubPartition Level
prompt ***************

select 
    PARTITION_NAME,
    SUBPARTITION_NAME,
    NUM_ROWS,
    BLOCKS,
    EMPTY_BLOCKS,
    AVG_SPACE,
    CHAIN_CNT,
    AVG_ROW_LEN,
    GLOBAL_STATS,
    USER_STATS,
    SAMPLE_SIZE,
    to_char(t.last_analyzed,'MM-DD-YYYY')
from 
    dba_tab_subpartitions t
where 
    table_owner = upper(nvl('&&owner',user))
and table_name = upper('&&table_name')
order by SUBPARTITION_POSITION
/
break on partition_name
select 
    p.PARTITION_NAME,
    t.SUBPARTITION_NAME,
    t.COLUMN_NAME,
    t.NUM_DISTINCT,
    t.DENSITY,
    t.NUM_BUCKETS,
    t.NUM_NULLS,
    t.GLOBAL_STATS,
    t.USER_STATS,
    t.SAMPLE_SIZE,
    to_char(t.last_analyzed,'MM-DD-YYYY')
from 
    dba_SUBPART_COL_STATISTICS t, 
    dba_tab_subpartitions p
where 
    t.table_name = upper('&&table_name')
and t.owner = upper(nvl('&&owner',user))
and t.subpartition_name = p.subpartition_name
and t.owner = p.table_owner
and t.table_name=p.table_name
/

break on partition_name
select 
    t.INDEX_NAME,
    t.PARTITION_NAME,
    t.SUBPARTITION_NAME,
    t.BLEVEL BLev,
    t.LEAF_BLOCKS,
    t.DISTINCT_KEYS,
    t.NUM_ROWS,
    t.AVG_LEAF_BLOCKS_PER_KEY,
    t.AVG_DATA_BLOCKS_PER_KEY,
    t.CLUSTERING_FACTOR,
    t.GLOBAL_STATS,
    t.USER_STATS,
    t.SAMPLE_SIZE,
    to_char(t.last_analyzed,'MM-DD-YYYY')
from 
    dba_ind_subpartitions t, 
    dba_indexes i
where 
    i.table_name = upper('&&table_name')
and i.table_owner = upper(nvl('&&owner',user))
and i.owner = t.index_owner
and i.index_name=t.index_name
/

clear breaks
set echo on