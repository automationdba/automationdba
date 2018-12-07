
set markup html on
SET TERMOUT OFF;
COLUMN current_instance NEW_VALUE current_instance NOPRINT;
COLUMN db_unique_name NEW_VALUE db_unique_name NOPRINT;
COLUMN current_timestamp NEW_VALUE current_timestamp  NOPRINT;
SELECT rpad(sys_context('USERENV', 'DB_UNIQUE_NAME'),15)  db_unique_name  FROM DUAL;
SELECT rpad(instance_name, 17) current_instance,rpad(to_char(current_timestamp,'DD-MON-YY HH24:MI'),17) current_timestamp FROM v$instance;
SET TERMOUT ON

PROMPT
PROMPT +----------------------------------------------------------+
PROMPT   Report   : Latch Event    
PROMPT   DB_Name  : &db_unique_name 
PROMPT   Timestamp: &current_timestamp
PROMPT +----------------------------------------------------------+

select /*+ ordered */  w1.username waiting_username, w1.inst_id,w1.sid  waiting_session,
        h1.inst_id,h1.sid  holding_session, h1.username holding_username,
        w.kgllktype lock_or_pin,
        w.kgllkhdl address,
        decode(h.kgllkmod,  0, 'None', 1, 'Null', 2, 'Share', 3, 'Exclusive',
           'Unknown') mode_held,
        decode(w.kgllkreq,  0, 'None', 1, 'Null', 2, 'Share', 3, 'Exclusive',
           'Unknown') mode_requested
  from dba_kgllock w, dba_kgllock h, gv$session w1, gv$session h1
 where
  (((h.kgllkmod != 0) and (h.kgllkmod != 1)
     and ((h.kgllkreq = 0) or (h.kgllkreq = 1)))
   and
     (((w.kgllkmod = 0) or (w.kgllkmod= 1))
     and ((w.kgllkreq != 0) and (w.kgllkreq != 1))))
  and  w.kgllktype       =  h.kgllktype
  and  w.kgllkhdl        =  h.kgllkhdl
  and  w.kgllkuse     =   w1.saddr
  and  h.kgllkuse     =   h1.saddr
/
prompt The following SQL will locate locked objects:
prompt
prompt select to_owner,to_name from v$object_dependency where to_address = 'v_address'
prompt
prompt ! See MetaLink article 169139.1 for more information !
prompt