--
-- PostgreSQL database dump
--

-- Dumped from database version 11.1
-- Dumped by pg_dump version 11.1

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: auth_group; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.auth_group (
    id integer NOT NULL,
    name character varying(80) NOT NULL
);


--
-- Name: auth_group_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.auth_group_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: auth_group_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.auth_group_id_seq OWNED BY public.auth_group.id;


--
-- Name: auth_group_permissions; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.auth_group_permissions (
    id integer NOT NULL,
    group_id integer NOT NULL,
    permission_id integer NOT NULL
);


--
-- Name: auth_group_permissions_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.auth_group_permissions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: auth_group_permissions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.auth_group_permissions_id_seq OWNED BY public.auth_group_permissions.id;


--
-- Name: auth_permission; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.auth_permission (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    content_type_id integer NOT NULL,
    codename character varying(100) NOT NULL
);


--
-- Name: auth_permission_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.auth_permission_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: auth_permission_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.auth_permission_id_seq OWNED BY public.auth_permission.id;


--
-- Name: auth_user; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.auth_user (
    id integer NOT NULL,
    password character varying(128) NOT NULL,
    last_login timestamp with time zone,
    is_superuser boolean NOT NULL,
    username character varying(150) NOT NULL,
    first_name character varying(30) NOT NULL,
    last_name character varying(150) NOT NULL,
    email character varying(254) NOT NULL,
    is_staff boolean NOT NULL,
    is_active boolean NOT NULL,
    date_joined timestamp with time zone NOT NULL
);


--
-- Name: auth_user_groups; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.auth_user_groups (
    id integer NOT NULL,
    user_id integer NOT NULL,
    group_id integer NOT NULL
);


--
-- Name: auth_user_groups_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.auth_user_groups_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: auth_user_groups_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.auth_user_groups_id_seq OWNED BY public.auth_user_groups.id;


--
-- Name: auth_user_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.auth_user_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: auth_user_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.auth_user_id_seq OWNED BY public.auth_user.id;


--
-- Name: auth_user_user_permissions; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.auth_user_user_permissions (
    id integer NOT NULL,
    user_id integer NOT NULL,
    permission_id integer NOT NULL
);


--
-- Name: auth_user_user_permissions_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.auth_user_user_permissions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: auth_user_user_permissions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.auth_user_user_permissions_id_seq OWNED BY public.auth_user_user_permissions.id;


--
-- Name: dbawebmenu_dbaloginuser; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.dbawebmenu_dbaloginuser (
    db_user_id character varying(20) NOT NULL,
    user_email character varying(200) NOT NULL,
    username character varying(100) NOT NULL,
    user_type character varying(100) NOT NULL,
    user_status character varying(1) NOT NULL,
    last_updated timestamp with time zone NOT NULL,
    comments character varying(200) NOT NULL
);


--
-- Name: dbawebmenu_dbamenu; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.dbawebmenu_dbamenu (
    task_number integer NOT NULL,
    task_name character varying(100) NOT NULL,
    task_summary character varying(500) NOT NULL,
    task_sqlquery text NOT NULL
);


--
-- Name: django_admin_log; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.django_admin_log (
    id integer NOT NULL,
    action_time timestamp with time zone NOT NULL,
    object_id text,
    object_repr character varying(200) NOT NULL,
    action_flag smallint NOT NULL,
    change_message text NOT NULL,
    content_type_id integer,
    user_id integer NOT NULL,
    CONSTRAINT django_admin_log_action_flag_check CHECK ((action_flag >= 0))
);


--
-- Name: django_admin_log_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.django_admin_log_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: django_admin_log_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.django_admin_log_id_seq OWNED BY public.django_admin_log.id;


--
-- Name: django_content_type; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.django_content_type (
    id integer NOT NULL,
    app_label character varying(100) NOT NULL,
    model character varying(100) NOT NULL
);


--
-- Name: django_content_type_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.django_content_type_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: django_content_type_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.django_content_type_id_seq OWNED BY public.django_content_type.id;


--
-- Name: django_migrations; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.django_migrations (
    id integer NOT NULL,
    app character varying(255) NOT NULL,
    name character varying(255) NOT NULL,
    applied timestamp with time zone NOT NULL
);


--
-- Name: django_migrations_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.django_migrations_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: django_migrations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.django_migrations_id_seq OWNED BY public.django_migrations.id;


--
-- Name: django_session; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.django_session (
    session_key character varying(40) NOT NULL,
    session_data text NOT NULL,
    expire_date timestamp with time zone NOT NULL
);


--
-- Name: auth_group id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.auth_group ALTER COLUMN id SET DEFAULT nextval('public.auth_group_id_seq'::regclass);


--
-- Name: auth_group_permissions id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.auth_group_permissions ALTER COLUMN id SET DEFAULT nextval('public.auth_group_permissions_id_seq'::regclass);


--
-- Name: auth_permission id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.auth_permission ALTER COLUMN id SET DEFAULT nextval('public.auth_permission_id_seq'::regclass);


--
-- Name: auth_user id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.auth_user ALTER COLUMN id SET DEFAULT nextval('public.auth_user_id_seq'::regclass);


--
-- Name: auth_user_groups id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.auth_user_groups ALTER COLUMN id SET DEFAULT nextval('public.auth_user_groups_id_seq'::regclass);


--
-- Name: auth_user_user_permissions id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.auth_user_user_permissions ALTER COLUMN id SET DEFAULT nextval('public.auth_user_user_permissions_id_seq'::regclass);


--
-- Name: django_admin_log id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.django_admin_log ALTER COLUMN id SET DEFAULT nextval('public.django_admin_log_id_seq'::regclass);


--
-- Name: django_content_type id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.django_content_type ALTER COLUMN id SET DEFAULT nextval('public.django_content_type_id_seq'::regclass);


--
-- Name: django_migrations id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.django_migrations ALTER COLUMN id SET DEFAULT nextval('public.django_migrations_id_seq'::regclass);


--
-- Data for Name: auth_group; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.auth_group (id, name) FROM stdin;
\.


--
-- Data for Name: auth_group_permissions; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.auth_group_permissions (id, group_id, permission_id) FROM stdin;
\.


--
-- Data for Name: auth_permission; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.auth_permission (id, name, content_type_id, codename) FROM stdin;
1	Can add log entry	1	add_logentry
2	Can change log entry	1	change_logentry
3	Can delete log entry	1	delete_logentry
4	Can view log entry	1	view_logentry
5	Can add permission	2	add_permission
6	Can change permission	2	change_permission
7	Can delete permission	2	delete_permission
8	Can view permission	2	view_permission
9	Can add group	3	add_group
10	Can change group	3	change_group
11	Can delete group	3	delete_group
12	Can view group	3	view_group
13	Can add user	4	add_user
14	Can change user	4	change_user
15	Can delete user	4	delete_user
16	Can view user	4	view_user
17	Can add content type	5	add_contenttype
18	Can change content type	5	change_contenttype
19	Can delete content type	5	delete_contenttype
20	Can view content type	5	view_contenttype
21	Can add session	6	add_session
22	Can change session	6	change_session
23	Can delete session	6	delete_session
24	Can view session	6	view_session
25	Can add author	7	add_author
26	Can change author	7	change_author
27	Can delete author	7	delete_author
28	Can view author	7	view_author
29	Can add book	8	add_book
30	Can change book	8	change_book
31	Can delete book	8	delete_book
32	Can view book	8	view_book
33	Can add book instance	9	add_bookinstance
34	Can change book instance	9	change_bookinstance
35	Can delete book instance	9	delete_bookinstance
36	Can view book instance	9	view_bookinstance
37	Set book as returned	9	can_mark_returned
38	Can add genre	10	add_genre
39	Can change genre	10	change_genre
40	Can delete genre	10	delete_genre
41	Can view genre	10	view_genre
42	Can add language	11	add_language
43	Can change language	11	change_language
44	Can delete language	11	delete_language
45	Can view language	11	view_language
46	Can add dbamenu	12	add_dbamenu
47	Can change dbamenu	12	change_dbamenu
48	Can delete dbamenu	12	delete_dbamenu
49	Can add dbaloginuser	13	add_dbaloginuser
50	Can change dbaloginuser	13	change_dbaloginuser
51	Can delete dbaloginuser	13	delete_dbaloginuser
52	Can add dbaloginuser	14	add_dbaloginuser
53	Can change dbaloginuser	14	change_dbaloginuser
54	Can delete dbaloginuser	14	delete_dbaloginuser
55	Can add dbamenu	15	add_dbamenu
56	Can change dbamenu	15	change_dbamenu
57	Can delete dbamenu	15	delete_dbamenu
\.


--
-- Data for Name: auth_user; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.auth_user (id, password, last_login, is_superuser, username, first_name, last_name, email, is_staff, is_active, date_joined) FROM stdin;
2	pbkdf2_sha256$100000$gjuwkRheIQjR$X+bgCWs0VoDHKZ21//Zhhzk5k2ckV6kBohbHYMWjPe8=	2018-09-20 16:38:21.887+05:30	t	ketan	Ketan	Varia	KNVaria@consultantemail.com	f	t	2018-09-18 08:24:26+05:30
1	pbkdf2_sha256$100000$sH0xMPcYSYrQ$m9qBiRW+7usZ8BGUXiMomXCY0q6Bgj41HN30C4IK2GA=	2018-12-06 10:20:29.506705+05:30	t	admin			test@test.com	t	t	2018-08-20 17:47:43.645+05:30
\.


--
-- Data for Name: auth_user_groups; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.auth_user_groups (id, user_id, group_id) FROM stdin;
\.


--
-- Data for Name: auth_user_user_permissions; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.auth_user_user_permissions (id, user_id, permission_id) FROM stdin;
1	2	48
2	2	46
3	2	47
\.


--
-- Data for Name: dbawebmenu_dbaloginuser; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.dbawebmenu_dbaloginuser (db_user_id, user_email, username, user_type, user_status, last_updated, comments) FROM stdin;
ketan	automationdba@gmail.com	ketan	monitor	A	2018-09-21 21:23:58+05:30	
loadtest	automationdba@gmail.com	loadtest	apps	A	2018-11-06 15:33:10+05:30	loadtest oracle db user
\.


--
-- Data for Name: dbawebmenu_dbamenu; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.dbawebmenu_dbamenu (task_number, task_name, task_summary, task_sqlquery) FROM stdin;
5	SQL Advisor(sql_id)	SQL Advisor(sql_id)	define sqlid = &1\r\ndefine report_name = &2\r\n \r\nRem\r\nRem $Header: sqltrpt.sql 11-apr-2005.11:01:39 pbelknap Exp $\r\nRem\r\nRem sqltrpt.sql\r\nRem\r\nRem Copyright (c) 2004, 2005, Oracle. All rights reserved.  \r\nRem\r\nRem    NAME\r\nRem      sqltrpt.sql - SQL Tune RePorT\r\nRem\r\nRem    DESCRIPTION\r\nRem      Script that gets a single statement as input from the user (via SQLID),\r\nRem      tunes that statement, and then displays the text report.\r\nRem\r\nRem      To tune multiple statements, create a sql tuning set and create a\r\nRem      tuning task with it as input (see dbmssqlt.sql).\r\nRem\r\nRem    NOTES\r\nRem      <other useful comments, qualifications, etc.>\r\nRem\r\nRem    MODIFIED   (MM/DD/YY)\r\nRem    pbelknap    04/11/05 - remove linesize \r\nRem    kyagoub     07/05/04 - kyagoub_proj_13448-2\r\nRem    pbelknap    06/29/04 - feedback from rae burns \r\nRem    pbelknap    06/17/04 - Created\r\nRem\r\n\r\nSET NUMWIDTH 10\r\nSET TAB OFF\r\n\r\n--spool sql_advisor_v1101_test.lst\r\nspool '&report_name' \r\nset long 1000000;\r\nset longchunksize 1000;\r\nset feedback off;\r\nset veri off;\r\n\r\n-- Get the sql statement to tune\r\n\r\nprompt\r\nprompt Tune the sql\r\nprompt ~~~~~~~~~~~~\r\nvariable task_name varchar2(64);\r\nvariable err       number;\r\n\r\n-- By default, no error\r\nexecute :err := 0;\r\n\r\n#define sqlid=&1\r\nset serveroutput on;\r\n\r\nDECLARE\r\n  cnt      NUMBER;\r\n  bid      NUMBER;\r\n  eid      NUMBER;\r\nBEGIN\r\n  -- If it's not in V$SQL we will have to query the workload repository\r\n  select count(*) into cnt from V$SQLSTATS where sql_id = '&&sqlid';\r\n\r\n  IF (cnt > 0) THEN\r\n    :task_name := dbms_sqltune.create_tuning_task(sql_id => '&&sqlid');\r\n  ELSE\r\n    select min(snap_id) into bid\r\n    from   dba_hist_sqlstat\r\n    where  sql_id = '&&sqlid';\r\n\r\n    select max(snap_id) into eid\r\n    from   dba_hist_sqlstat\r\n    where  sql_id = '&&sqlid';\r\n\r\n    :task_name := dbms_sqltune.create_tuning_task(begin_snap => bid,\r\n                                                  end_snap => eid,\r\n                                                  sql_id => '&&sqlid');\r\n  END IF;\r\n\r\n  dbms_sqltune.execute_tuning_task(:task_name);\r\n\r\nEXCEPTION\r\n  WHEN OTHERS THEN\r\n    :err := 1;\r\n\r\n    IF (SQLCODE = -13780) THEN\r\n      dbms_output.put_line ('ERROR: statement is not in the cursor cache ' ||\r\n                            'or the workload repository.');\r\n      dbms_output.put_line('Execute the statement and try again');\r\n    ELSE\r\n      RAISE;\r\n    END IF;   \r\n \r\nEND;\r\n/\r\n\r\nset heading off;\r\nselect dbms_sqltune.report_tuning_task(:task_name) from dual where :err <> 1;\r\nselect '   ' from dual where :err = 1;\r\nset heading on;\r\n\r\nundefine sqlid;\r\nset feedback on;\r\nset veri on;\r\nspool off
2	Session detail(SID)	Session detail(SID)	undefine inst_id\r\nundefine sid\r\n\r\ndefine inst_id=&1;\r\ndefine sid=&2;\r\n\r\nSET TERMOUT OFF;\r\nCOLUMN current_instance NEW_VALUE current_instance NOPRINT;\r\nCOLUMN db_unique_name NEW_VALUE db_unique_name NOPRINT;\r\nCOLUMN current_timestamp NEW_VALUE current_timestamp  NOPRINT;\r\nSELECT rpad(sys_context('USERENV', 'DB_UNIQUE_NAME'),15)  db_unique_name  FROM DUAL;\r\nSELECT rpad(instance_name, 17) current_instance,rpad(to_char(current_timestamp,'DD-MON-YY HH24:MI'),17) current_timestamp FROM v$instance;\r\nSET TERMOUT ON\r\n\r\nPROMPT\r\nPROMPT +----------------------------------------------------------+\r\nPROMPT   Report   : Session Details(Ins: &inst_id,SID:&sid )  \r\nPROMPT   DB_Name  : &db_unique_name \r\nPROMPT   Timestamp: &current_timestamp\r\nPROMPT +----------------------------------------------------------+\r\n\r\n--Get specific session details(RAC) include wait,sort,undo details\r\ncol inst format 999\r\ncol sid format 9999\r\ncol sql_id format a15\r\ncol username format a10\r\ncol osuser format a10\r\ncol program format a25\r\ncol process format 9999999\r\ncol spid format 999999\r\ncol logon_time format a13\r\n\r\n\r\ndefine inst_id=&1;\r\ndefine sid=&2;\r\n\r\nset heading off\r\nset verify off\r\nset feedback off\r\n\r\ncol sid NEW_VALUE sid noprint\r\ncol inst_id NEW_VALUE inst_id noprint\r\ncol spid NEW_VALUE spid noprint\r\n\r\n \r\n         SELECT  s.inst_id inst_id,s.sid sid,p.spid\r\n         FROM gv$session s,\r\n              gv$process p \r\n         WHERE s.inst_id = p.inst_id\r\n         AND s.sid=&sid\r\n\t AND s.inst_id=&inst_id\r\n         AND s.paddr = p.addr \r\n         ORDER BY s.inst_id,s.sid;\r\n\r\ncol sid NEW_VALUE sid print\r\ncol sql_id NEW_VALUE sid print\r\ncol inst_id NEW_VALUE inst_id print\r\n\r\nPROMPT Session and Process Information\r\nPROMPT -------------------------------\r\n\r\ncol event for a30\r\n\r\nselect 'Instance                        : '||v.inst_id  || chr(10)|| \r\n                '    SID                        : '||v.sid      || chr(10)|| \r\n                '    SQL ID                     : '||v.sql_id      || chr(10)|| \r\n       '    Serial Number               : '||v.serial#  || chr(10) ||\r\n       '    Oracle User Name            : '||v.username         || chr(10) ||\r\n       '    Client OS user name         : '||v.osuser   || chr(10) ||\r\n       '    Client Process ID           : '||v.process  || chr(10) ||\r\n       '    Client machine Name         : '||v.machine  || chr(10) ||\r\n       '    Oracle PID                  : '||p.pid      || chr(10) ||\r\n       '    OS Process ID(spid)         : '||p.spid     || chr(10) ||\r\n       '    Session''s Status           : '||v.status   || chr(10) ||\r\n       '    Logon Time                  : '||to_char(v.logon_time, 'MM/DD HH24:MIpm')   || chr(10) ||\r\n       '    Program Name                : '||v.program  || chr(10) \r\nfrom gv$session v, gv$process p\r\nwhere v.inst_id = p.inst_id\r\nand v.paddr = p.addr\r\nand v.serial# > 1\r\nand p.background is null\r\nand p.username is not null\r\nand sid = &sid\r\nand v.inst_id=&inst_id\r\norder by logon_time, v.status, 1\r\n/\r\nset heading on\r\ncol host for a20\r\ncol inst_name for a8 heading "Inst|Name"\r\n\r\ncol host_name for a25\r\nselect  distinct a.inst_id inst,a.sql_id sqlid,a.hash_value hash,a.address addr,c.instance_name inst_name,c.host_name host,c.instance_role inst_role\r\nfrom gv$sql a,gv$session b,gv$instance c\r\nwhere b.inst_id = c.inst_id\r\nand a.address = b.sql_address\r\nand b.inst_id = &inst_id\r\nand b.sid = &sid\r\norder by a.inst_id;\r\n\r\nPROMPT\r\nPROMPT SQL STATEMENT\r\nPROMPT -------------\r\n\r\n\r\ncol sql_text for a180\r\nset linesize 200\r\nset pagesize 250\r\nselect  a.sql_text\r\nfrom gv$sqltext a, gv$session b\r\nwhere a.inst_id=b.inst_id\r\nand a.address = b.sql_address\r\nand b.inst_id=&inst_id\r\nand b.sid = &sid\r\norder by b.inst_id,a.piece;\r\n\r\nset heading off\r\n\r\nPROMPT\r\nPROMPT Event Wait Information\r\nPROMPT ----------------------\r\n\r\nselect '   SID '|| &sid ||' is waiting on event : ' || x.event || chr(10) ||\r\n       '   P1 Text                      : ' || x.p1text || chr(10) ||\r\n       '   P1 Value                     : ' || x.p1 || chr(10) ||\r\n       '   P2 Text                      : ' || x.p2text || chr(10) ||\r\n       '   P2 Value                     : ' || x.p2 || chr(10) ||\r\n       '   P3 Text                      : ' || x.p3text || chr(10) ||\r\n       '   P3 Value                     : ' || x.p3  || chr(10) ||\r\n       '   State                        : ' || x.state  || chr(10) ||\r\n       '   second_in_wait               : ' || x.seconds_in_wait\r\nfrom gv$session_wait x\r\nwhere x.inst_id  = &inst_id\r\nand x.sid= &sid;\r\n\r\nset heading on\r\nPROMPT\r\nPROMPT Session Long Operation\r\nPROMPT ----------------------\r\n\r\n-- session long operation more than 30 minutes\r\nset linesize 160\r\nset pagesize 120\r\ncolumn Inst_id                 format 999      heading 'Inst|Id'\r\ncolumn sid                 format 9999      heading 'SID'\r\ncolumn serial              format 9999999   heading 'Serial#'\r\ncolumn elapsed_seconds format 999999 heading 'Elapsed|seconds'\r\ncolumn time_remaining format 999999 heading 'time|remaining'\r\ncolumn start_time format a19\r\ncolumn username format a10\r\ncolumn message format a60\r\nselect inst_id,sid,serial#,username,message,to_char(start_time,'dd-mon-yy hh24:mi:ss') start_time,elapsed_seconds,time_remaining from gv$session_longops\r\nwhere elapsed_seconds > 180 and inst_id=&inst_id and sid=&sid\r\norder by elapsed_seconds desc\r\n/\r\nset heading on
13	System wait event	System wait event details- instance specific	SET TERMOUT OFF;\r\nCOLUMN current_instance NEW_VALUE current_instance NOPRINT;\r\nCOLUMN db_unique_name NEW_VALUE db_unique_name NOPRINT;\r\nCOLUMN current_timestamp NEW_VALUE current_timestamp  NOPRINT;\r\nSELECT rpad(sys_context('USERENV', 'DB_UNIQUE_NAME'),15)  db_unique_name  FROM DUAL;\r\nSELECT rpad(instance_name, 17) current_instance,rpad(to_char(current_timestamp,'DD-MON-YY HH24:MI'),17) current_timestamp FROM v$instance;\r\ndefine userin=&1\r\n \r\nSET TERMOUT ON\r\n\r\nPROMPT\r\nPROMPT +------------------------------------------------------------------------+\r\nPROMPT   Report   \t: Current system wait event details(instance specific)\r\nPROMPT   DB_Name  \t: &db_unique_name\r\nPROMPT   Report Time \t: &current_timestamp\r\nPROMPT +------------------------------------------------------------------------+\r\n\r\n\r\n/**********************************************************************\r\n* File: systemevent.sql\r\n* Type: SQL*Plus script\r\n* Description:\r\n* This is possibly one of the most useful tuning scripts\r\n* available.\r\n*\r\n* The V$SYSTEM_EVENT dynamic performance view is the highest-level\r\n* view of the "Session Wait Interface". Information in this view\r\n* is cumulative since the database instance was started, and one\r\n* can get a very good idea of what types of contention a database\r\n* instance is (or is not) experiencing by monitoring this view.\r\n*\r\n* NOTE: this script sorts output by the TIME_WAITED column in the\r\n* V$SYSTEM_EVENT view. If the Oracle initialization parameter\r\n* TIMED_STATISTICS is not set to TRUE, then the TIME_WAITED\r\n* column will not be populated.\r\n*\r\n* Please *disregard* the advice of people who insist that turning\r\n* off TIMED_STATISTICS is somehow a performance boost. Whatever\r\n* performance overhead that might be incurred is more than\r\n* compensated for by the incredible tuning information that\r\n* results...\r\n*\r\n*********************************************************************/\r\nset echo off feedback off timing off pause off verify off\r\nset pagesize 80 linesize 500 trimspool on trimout on\r\ncol event format a26 truncate heading "Event Name"\r\ncol total_waits format 999,999,990 heading "Total|Waits|(in 1000s)"\r\ncol total_timeouts format 999,999,990 heading "Total|Timeouts|(in 1000s)"\r\ncol time_waited format 999,990.00 heading "Time|Waited|(in Hours)"\r\ncol pct_significant format 90.00 heading "% of|Concern"\r\ncol average_wait format 999,990.00 heading "Avg|Wait|(Secs)"\r\n\r\ncol total_time_waited new_value V_TOTAL_TIME_WAITED noprint\r\nselect sum(time_waited) total_time_waited\r\nfrom sys.v_$system_event\r\nwhere event not in ('SQL*Net message from client',\r\n'rdbms ipc message',\r\n'slave wait',\r\n'pmon timer',\r\n'smon timer',\r\n'rdbms ipc reply',\r\n'SQL*Net message to client',\r\n'SQL*Net break/reset to client',\r\n'inactive session',\r\n'Null event')\r\n/\r\n\r\n\r\nselect event,\r\n(total_waits / 1000) total_waits,\r\n(total_timeouts / 1000) total_timeouts,\r\n(time_waited / 360000) time_waited,\r\ndecode(event,\r\n'SQL*Net message from client', 0,\r\n'rdbms ipc message', 0,\r\n'slave wait', 0,\r\n'pmon timer', 0,\r\n'smon timer', 0,\r\n'rdbms ipc reply', 0,\r\n'SQL*Net message to client', 0,\r\n'SQL*Net break/reset to client', 0,\r\n'inactive session', 0,\r\n'Null event', 0,\r\n(time_waited / &&V_TOTAL_TIME_WAITED)*100) pct_significant,\r\n(average_wait / 100) average_wait\r\nfrom sys.v_$system_event\r\nwhere (time_waited/360000) >= 0.01\r\norder by pct_significant desc, time_waited desc\r\n/
14	High-CPU Sessions	High-CPU Sessions	-- sessions with highest CPU +DB consumption(Last 4 hours Logged session)\r\n\r\nSET TERMOUT OFF;\r\nCOLUMN current_instance NEW_VALUE current_instance NOPRINT;\r\nCOLUMN db_unique_name NEW_VALUE db_unique_name NOPRINT;\r\nCOLUMN current_timestamp NEW_VALUE current_timestamp  NOPRINT;\r\nSELECT rpad(sys_context('USERENV', 'DB_UNIQUE_NAME'),15)  db_unique_name  FROM DUAL;\r\nSELECT rpad(instance_name, 17) current_instance,rpad(to_char(current_timestamp,'DD-MON-YY HH24:MI'),17) current_timestamp FROM v$instance;\r\nSET TERMOUT ON\r\n\r\nPROMPT\r\nPROMPT +------------------------------------------------------------------------+\r\nPROMPT   Report   : Top CPU Sessions\r\nPROMPT   DB_Name  : &db_unique_name\r\nPROMPT   Timestamp: &current_timestamp\r\nPROMPT +------------------------------------------------------------------------+\r\n\r\n\r\nset linesize 200\r\nset pagesize 160\r\ncol username format a10\r\ncol module format a22\r\ncol connected format A17 heading "Connected"\r\ncol "DB sec" format 99999999 heading "DB|sec"\r\ncol "CPU sec" format 99999999 heading "CPU|sec"\r\nspool top_cpu_rac.lst\r\n--col sid for 9999\r\n--col serial# for 99999\r\ncol spid for a7 heading "OS PID"\r\ncol BLOCKING_SESSION_STATUS for a11 heading "Blocking"\r\ncol inst_id for 99 heading "Inst"\r\ncol MACHINE for a23 heading "machine"\r\ncol sess for a12 heading 'SID|Serial#'\r\ncol WAIT_CLASS for a15\r\ncol service_name for a15\r\ncol blocks for a10 heading "Blocking|Session"\r\ncol waits for 99999\r\nSELECT s.inst_id,'('||s.sid||','||s.serial#||')' sess, p.spid,s.username, TO_CHAR(S.LOGON_TIME,'YYYY-MM-DD HH24:MI') connected,substr(s.module,1,22) module, st.value/100 as "CPU sec",st2.value/100 as "DB sec",s.blocking_session_status,s.MACHINE,s.sql_id\r\n--,s.WAIT_CLASS,s.service_name,'('||BLOCKING_INSTANCE||','||BLOCKING_SESSION||')' blocks\r\nFROM gv$sesstat st, gv$statname sn, gv$session s, gv$process p, gv$sesstat st2 ,gv$statname sn2\r\nWHERE sn.name = 'CPU used by this session' -- CPU\r\nAND sn2.name = 'DB time' -- CPU\r\nAND st2.statistic# = sn2.statistic#\r\nand s.inst_id=st.inst_id and p.inst_id=s.inst_id and sn.inst_id=st.inst_id\r\nand s.inst_id=st2.inst_id  and sn2.inst_id=st2.inst_id\r\nAND st.statistic# = sn.statistic#\r\nAND st.sid = s.sid\r\nAND st2.sid = s.sid\r\nAND s.paddr = p.addr\r\nand blocking_session_status <> 'NO HOLDER'\r\n--AND s.last_call_et < 1800 -- active within last 1/2 hour\r\n--AND s.logon_time > (SYSDATE - 240/1440) -- sessions logged on within 4 hours\r\nORDER BY st.value desc;\r\nspool off
1	Current session(SID/Username/OS-User/Module)	Get Session(SID/Username/OS-User/Module)	undefine input\r\ndefine input=&1\r\n\r\nSET TERMOUT OFF;\r\nCOLUMN current_instance NEW_VALUE current_instance NOPRINT;\r\nCOLUMN db_unique_name NEW_VALUE db_unique_name NOPRINT;\r\nCOLUMN current_timestamp NEW_VALUE current_timestamp  NOPRINT;\r\nSELECT rpad(sys_context('USERENV', 'DB_UNIQUE_NAME'),15)  db_unique_name  FROM DUAL;\r\nSELECT rpad(instance_name, 17) current_instance,rpad(to_char(current_timestamp,'DD-MON-YY HH24:MI'),17) current_timestamp FROM v$instance;\r\nSET TERMOUT ON\r\n\r\nPROMPT\r\nPROMPT +----------------------------------------+\r\nPROMPT   Report   : Get session detail ('&input') \r\nPROMPT   DB_Name  : &db_unique_name \r\nPROMPT   Timestamp: &current_timestamp\r\nPROMPT +----------------------------------------+\r\n\r\n\r\n\r\n------------------------------------------------\r\n-- Show Active/Inactive Sessions for Only Users\r\n---------------------------------------------\r\nset linesize 180\r\nset pagesize 60\r\n--clear columns\r\n--clear breaks\r\n\r\nttitle off\r\n\r\ncolumn usr                 format a21       Heading 'Osuser  /User'\r\ncolumn sid                 format 9999      heading 'S|I|D'\r\ncolumn connected           format A16       heading 'Connected'\r\ncolumn stat                format A1        heading 'S|t|a|t'\r\ncolumn serial              format 9999999   heading 'Serial#'\r\ncolumn machine             format A20       heading 'Machine'\r\ncolumn logical             format A19       heading '      Logical|    Gets / Chgs'\r\ncolumn physical_reads      format 9999999 heading 'Physical|Reads'\r\ncolumn SECONDS_IN_WAIT     format 9999999 heading 'WAIT|Seconds'\r\ncolumn chgs                format A9        heading 'Logical|  Chgs'\r\ncolumn consistent_changes  format 999999999 heading 'Consist|Changes'\r\ncolumn module              format A12       heading 'Module'\r\ncolumn instance            format A13       heading 'Inst:|Sid,Serial#'\r\ncolumn sql_id              format A13       heading 'SQL ID'\r\ncolumn sess_event          format A16       heading 'Sess|Event'\r\ncolumn Command_Type        format A10       heading 'SQL|Type'\r\ncol state for a12\r\ncol SQL_Type for A9\r\nset verify off\r\nSELECT s.inst_id||':'||S.SID||','||S.SERIAL# instance, rpad(S.OSUSER,8)||'/'||rpad(S.USERNAME,12) Usr,\r\n       substr(S.STATUS,1,1) STAT,\r\n       TO_CHAR(S.LOGON_TIME,'YYYY-MM-DD HH24:MI') connected,\r\n       substr(S.MACHINE,1,20) MACHINE,\r\n       substr(S.MODULE,1,24) module,\r\n\tsubstr(AA.NAME,1,15) Command_Type,\r\n\ts.sql_id,\r\n\tS.state,\r\n\tSECONDS_IN_WAIT,\r\n\tsubstr(s.event,1,30) sess_event\r\n  FROM\r\n       GV$SESSION S,\r\n\tAUDIT_ACTIONS AA\r\n WHERE\r\n    S.USER# != 0\r\n   and S.command=AA.ACTION\r\n   and ((to_char(s.sid)='&input') or (upper(S.OSUSER) like upper('%&input%')) or (upper(S.USERNAME) like upper('%&input%')) or (upper(S.sql_id) like upper ('&&input%')) or (upper(s.module) like upper('%&input%'))) \r\n ORDER BY 1,4,3;\r\nPROMPT\r\nPROMPT Additional details\r\nPROMPT +----------------+\r\n\r\ncol actions for a25\r\ncol sql_text for a40\r\ncol CLIENT_INFO for a15\r\ncol ACTION for a15\r\ncol plsql_object for a30 heading 'Plsql Object Details'\r\ncol plsql_entry_subprogram for a15 heading 'Plsql entry|Subprogram'\r\ncol OBJECT for a15 heading 'Row wait|Object'\r\ncol BLOCKING_SESSION_STATUS for a11 heading 'Blockng|Sess Stat'\r\ncol SQL_HASH_VALUE for 9999999999 heading 'SQL|HASH VALUE'\r\nSELECT s.inst_id||':'||S.SID||','||S.SERIAL# instance\r\n,( SELECT substr(object_name,1,12)    FROM dba_procedures WHERE object_id = plsql_entry_object_id AND subprogram_id = 0) ||'/'|| \r\n( SELECT substr(procedure_name,1,12) FROM dba_procedures WHERE object_id = plsql_entry_object_id AND subprogram_id = plsql_entry_subprogram_id)||'/'|| \r\n( SELECT substr(object_name,1,12)    FROM dba_procedures WHERE object_id = plsql_object_id       AND subprogram_id = 0) AS plsql_object\r\n--rpad(S.OSUSER,8)||'/'||rpad(S.USERNAME,10) Usr_detail, substr(S.STATUS,1,1) STAT, S.SQL_ID,\r\n,S.PREV_SQL_ID previous_sql\r\n,TO_CHAR(S.SQL_EXEC_START,'YYYY-MM-DD HH24:MI') SQL_EXEC_START\r\n,round(TIME_REMAINING_MICRO/1000000,1) Sec_Remain\r\n--       lpad(to_char(I.BLOCK_GETS+I.CONSISTENT_GETS),9)||'/'|| lpad(to_char(I.BLOCK_CHANGES+I.CONSISTENT_CHANGES),9) logical\r\n--       I.PHYSICAL_READS\r\n,S.SQL_HASH_VALUE,S.CLIENT_INFO,S.ACTION,substr(O.object_name,1,30) Object\r\n,BLOCKING_SESSION_STATUS \r\nFROM\r\n       GV$SESSION S, \r\n       GV$SESS_IO I,\r\n\tDBA_OBJECTS O\t\r\n WHERE\r\n       S.SID = I.SID\r\n   AND S.INST_ID = I.INST_ID\r\n   AND S.USER# != 0\r\n  AND o.OBJECT_ID (+)=s.ROW_WAIT_OBJ#\r\n   and ((to_char(s.sid)='&input') or (upper(S.OSUSER) like upper('%&input%')) or (upper(S.USERNAME) like upper('%&input%')) or (upper(S.sql_id) like upper ('&&input%')))\r\n ORDER BY 1,2;\r\n   --  S.INST_ID = A.INST_ID\r\n   -- AND S.SQL_ID = A.SQL_ID\r\n  --  AND S.SQL_ADDRESS    = A.ADDRESS\r\n  --  AND S.SQL_HASH_VALUE = A.HASH_VALUE
3	SQL Current plan hash value(sql_id)	SQL CurrPlan(sql_id)	SET TERMOUT OFF;\r\nCOLUMN current_instance NEW_VALUE current_instance NOPRINT;\r\nCOLUMN db_unique_name NEW_VALUE db_unique_name NOPRINT;\r\nCOLUMN current_timestamp NEW_VALUE current_timestamp  NOPRINT;\r\nSELECT rpad(sys_context('USERENV', 'DB_UNIQUE_NAME'),15)  db_unique_name  FROM DUAL;\r\nSELECT rpad(instance_name, 17) current_instance,rpad(to_char(current_timestamp,'DD-MON-YY HH24:MI'),17) current_timestamp FROM v$instance;\r\nSET TERMOUT ON\r\n\r\ndefine sql_id=&1\r\n--COLUMN sql_id  NEW_VALUE sql_id NOPRINT;\r\n\r\nPROMPT +------------------------------------------------------------------------+\r\nPROMPT   Report   : SQL Details for sql_id:&sql_id\r\nPROMPT   Instance : &current_instance\r\nPROMPT   Timestamp: &current_timestamp\r\nPROMPT +------------------------------------------------------------------------+\r\n\r\nSET ECHO        OFF\r\nSET FEEDBACK    6\r\nSET HEADING     ON\r\nSET LINESIZE    180\r\nSET PAGESIZE    50000\r\nSET TERMOUT     ON\r\nSET TIMING      OFF\r\nSET TRIMOUT     ON\r\nSET TRIMSPOOL   ON\r\nSET VERIFY      OFF\r\n\r\nCLEAR COLUMNS\r\nCLEAR BREAKS\r\nCLEAR COMPUTES\r\n\r\nCOLUMN group_name             FORMAT a30           HEAD 'Disk Group|Name'\r\nCOLUMN sector_size            FORMAT 99,999        HEAD 'Sector|Size'\r\nCOLUMN block_size             FORMAT 99,999        HEAD 'Block|Size'\r\n--COLUMN allocation_unit_size   FORMAT 999,999,999   HEAD 'Allocation|Unit Size'\r\nCOLUMN state                  FORMAT a11           HEAD 'State'\r\nCOLUMN type                   FORMAT a6            HEAD 'Type'\r\nCOLUMN remote                 FORMAT a1            HEAD 'R|E|M|O|T|E'\r\nCOLUMN plan_hash_value        FORMAT 9999999999    HEAD 'Plan|Hash Value'\r\nCOLUMN invalidations          FORMAT 999999        HEAD 'Invalid'\r\nCOLUMN elapsed_time           FORMAT 99999999999   HEAD 'elapsed|time'\r\nCOLUMN total_gb               FORMAT 999,999,999   HEAD 'Total Size (GB)'\r\nCOLUMN used_gb                FORMAT 999,999,999   HEAD 'Used Size (GB)'\r\nCOLUMN free_gb                FORMAT 999,999,999   HEAD 'Free Size (GB)'\r\nCOLUMN pct_used               FORMAT 999.99        HEAD 'Pct. Used'\r\n\r\n--select sql_id, invalidations, loads from v$sql where lower(sql_id)like lower(rtrim(ltrim(('&sql_id'))));\r\n--select PLAN_HASH_VALUE,SQL_ID, OBJECT_STATUS,ROWS_PROCESSED from gv$sqlarea where sql_id='&sql_id';\r\nPROMPT SQL CURR PLAN\r\nset term on feed on echo on \r\nselect sql_id ,plan_hash_value,hash_value,old_hash_value, executions,rows_processed,loads,invalidations,elapsed_time,remote, parse_calls\r\nfrom gv$sqlarea where sql_id='&sql_id';\r\n\r\nset term off\r\nPROMPT  SQL HIST PLAN\r\n\r\nselect distinct plan_hash_value, to_char(timestamp, 'dd-MON-yyyy hh24:mi:ss') timestamp \r\nfrom dba_hist_sql_plan where sql_id = '&sql_id'\r\norder by timestamp desc;\r\n\r\nPROMPT\r\n\r\nCOLUMN user_io_wait_time      FORMAT 99999999999   HEAD 'user_io|wait_time'\r\nCOLUMN sorts      FORMAT 999999   HEAD 'sorts'\r\nselect SORTS\r\n,FETCHES\r\n,DISK_READS\r\n,DIRECT_WRITES\r\n,BUFFER_GETS\r\n,USER_IO_WAIT_TIME\r\n,SQL_PLAN_BASELINE\r\n,OBJECT_STATUS from gv$sqlarea\r\nwhere SQL_ID = '&sql_id';\r\n\r\nPROMPT  Query Progress...\r\n--select SQL_HANDLE, PLAN_NAME,ENABLED,ACCEPTED,AUTOPURGE,creator,CREATED from dba_sql_plan_baselines;\r\nset linesize 200\r\nset echo on\r\nset pagesize 2000\r\ncol table_owner for a10\r\ncol table_name for a30\r\ncol num_rows for 99999999\r\ncol inserts for 9999999\r\ncol updates for 9999999\r\ncol deletes for 9999999\r\ncol partition_name for a16\r\ncol truncated for a3 head 'Trun|cate'\r\ncol stale_stats for a4 head 'Stal|stat'\r\nselect distinct b.table_owner,b.table_name, b.partition_name, b.inserts, b.updates, b.deletes, b.TRUNCATED,c.STALE_STATS,\r\nto_char(b.timestamp, 'mm/dd/yyyy hh24:mi') timestamp, to_char(c.last_analyzed, 'mm/dd/yyyy hh24:mi') last_analyzed,\r\nc.num_rows\r\nfrom (select distinct sql_id, object#, object_name, object_owner from v$sql_plan where sql_id = '&&sql_id' UNION select distinct sql_id, object#, object_name, object_owner from dba_hist_sql_plan where sql_id = '&&sql_id') a\r\n, sys.dba_tab_modifications b, dba_tab_statistics c\r\nwhere a.sql_id = '&sql_id'\r\nand  a.OBJECT_OWNER = b.table_owner\r\nand  a.OBJECT_NAME = b.table_name\r\nand  b.table_owner = c.owner\r\nand  b.table_name  = c.table_name\r\nand  NVL(b.partition_name,'NONE') = NVL(c.partition_name,'NONE')\r\nand b.table_name is not null\r\norder by b.table_owner, b.table_name, b.partition_name;\r\nexit
4	Long query(sql_id)	Long Query(sql_id)	undefine sql_id\r\ndefine sql_id=&1\r\n\r\nSET TERMOUT OFF;\r\nCOLUMN current_instance NEW_VALUE current_instance NOPRINT;\r\nCOLUMN db_unique_name NEW_VALUE db_unique_name NOPRINT;\r\nCOLUMN current_timestamp NEW_VALUE current_timestamp  NOPRINT;\r\nSELECT rpad(sys_context('USERENV', 'DB_UNIQUE_NAME'),15)  db_unique_name  FROM DUAL;\r\nSELECT rpad(instance_name, 17) current_instance,rpad(to_char(current_timestamp,'DD-MON-YY HH24:MI'),17) current_timestamp FROM v$instance;\r\nSET TERMOUT ON\r\n\r\nPROMPT\r\nPROMPT +----------------------------------------+\r\nPROMPT   Report   : Long running session detail  \r\nPROMPT   DB_Name  : &db_unique_name \r\nPROMPT   Timestamp: &current_timestamp\r\nPROMPT +----------------------------------------+\r\n\r\n\r\nset verify off\r\nset feed off\r\ncol PLAN_HASH_VALUE for 999999999999 heading 'Plan Hash|Value'\r\ncolumn sql_id NEW_VALUE sql_id\r\nselect distinct plan_hash_value, to_char(timestamp, 'dd-MON-yyyy hh24:mi ss') timestamp from dba_hist_sql_plan where sql_id = '&sql_id'\r\norder by 2;\r\n\r\nset feed on\r\nprompt\r\nprompt RESOURCE UTILIZATION current executing query(only if more than 5 sec cpu or i/o utilized)\r\nprompt\r\ncol inst_id format 99 heading 'I|N|S' \r\ncol sid for 9999 \r\nSELECT inst_id,sid,status,buffer_gets, disk_reads, round(cpu_time/1000000,1) cpu_seconds,round(elapsed_time/1000000,1) exe_seconds,round(APPLICATION_WAIT_TIME/1000000,1) appln_wait,px_server# \r\nFROM gv$sql_monitor\r\nWHERE sql_id='&sql_id' order by  px_server#;\r\nset feed off\r\n\r\nPROMPT\r\nPROMPT\r\nPROMPT +------------------------------------------------------------------------+\r\nPROMPT | CURRENT SESSION DETAIL                                                 |\r\nPROMPT +------------------------------------------------------------------------+\r\ncolumn usr                 format a20       Heading 'Osuser/User'\r\ncolumn sid                 format 9999      heading 'S|I|D'\r\ncolumn program             format A29       heading 'program'\r\ncolumn stat                format A1        heading 'S|t|a|t'\r\ncolumn serial              format 999999   heading 'Sr#'\r\ncolumn machine             format A20       heading 'Machine'\r\ncolumn logical             format A19       heading '      Logical|    Gets / Chgs'\r\ncolumn module              format A30       heading 'Module'\r\ncolumn sess_detail         format A14       heading 'Sess_details'\r\n\r\nset pagesize 300\r\ncol client_identifier for a30\r\nselect s.inst_id||':('||s.sid||','||s.serial#||')' sess_detail,s.sql_id,s.machine,s.osuser||' '||s.username usr,s.logon_time,s.program,s.event,s.status,s.client_identifier,s.MODULE \r\nfrom gv$session s,gv$process p \r\nwhere p.addr=s.paddr and s.sql_id='&sql_id';\r\n--before purge plan check is there any other session with same sql id ***********\r\n--exec sys.dbms_shared_pool.purge ('Address,hash_value','C');\r\n\r\ncolumn SORTS format 999999   heading 'Sorts'\r\ncolumn FETCHES format 999999   heading 'Fetches'\r\ncolumn DIRECT_WRITES format 999999   heading 'Drct_Wrts'\r\nselect inst_id,sql_id,SORTS,FETCHES,EXECUTIONS,PARSE_CALLS,DISK_READS,DIRECT_WRITES,BUFFER_GETS,ROWS_PROCESSED,ADDRESS,HASH_VALUE,OBJECT_STATUS from gv$sqlarea where SQL_ID = '&sql_id';\r\nPROMPT\r\n\r\n--cursor invalidate\r\n--EXEC DBMS_STATS.GATHER_TABLE_STATS(OWNNAME=>'OTS', TABNAME=>'TRN_HOLDINGS',  estimate_percent=>DBMS_STATS.AUTO_SAMPLE_SIZE, degree=>16, method_opt=>'for all columns size repeat');\r\n\r\ncol parsing_schema_name for a20 heading 'Parsing|Schema|Name'\r\ncol AVG_CPU_TIME for 9999999 heading 'avg_cpu|time'\r\ncol avg_elapsed_time for  9999999 heading 'avg_elap|time'\r\ncol IO_per_day_GB for  9999999 heading 'IO_per_day|GB'\r\nSELECT \r\nTO_CHAR(s.begin_interval_time, 'mm/dd/yyyy hh24:mi') AS Day,\r\n-- TO_CHAR(s.end_interval_time, 'mm/dd/yyyy hh24:mi') AS interval_end,\r\n--q.snap_id,\r\nparsing_schema_name,\r\n--module,\r\nq.sql_id ,\r\nq.plan_hash_value,\r\nSUM(executions_delta) AS executions ,\r\nROUND(SUM(cpu_time_delta) / 1000000 / SUM(executions_delta)) avg_cpu_time ,\r\nROUND(SUM(cpu_time_delta) / 1000000) total_cpu ,\r\nROUND(SUM(elapsed_time_delta) / 1000000 / SUM(executions_delta)) avg_elapsed_time ,\r\nROUND(SUM(elapsed_time_delta) / 1000000) total_elap ,\r\nround(ROUND(SUM(disk_reads_delta + direct_writes_delta)*8192/SUM(executions_delta), 4)/1024/1024) avg_io_MB,\r\nround(ROUND(SUM(disk_reads_delta + direct_writes_delta) * 8192, 4)/1024/1024/1024) IO_per_day_GB\r\nFROM dba_hist_sqlstat q, dba_hist_snapshot s\r\nWHERE q.dbid = s.dbid\r\nAND q.snap_id = s.snap_id\r\n--AND s.end_interval_time between TO_DATE('07/10/2012', 'mm/dd/yyyy') and TO_DATE('07/12/2012', 'mm/dd/yyyy')\r\n--AND parsing_schema_name in ('FIAADMIN' )\r\nand s.END_INTERVAL_TIME > sysdate-7\r\nand q.SQL_ID in ('&sql_id')\r\nGROUP BY\r\nTO_CHAR(s.begin_interval_time, 'mm/dd/yyyy hh24:mi')\r\n--, TO_CHAR(s.begin_interval_time, 'mm/dd/yyyy')\r\n,parsing_schema_name \r\n--, module\r\n--, q.snap_id\r\n, q.sql_id\r\n,q.plan_hash_value\r\nHAVING SUM(executions_delta) > 0\r\nORDER BY 1,IO_per_day_GB desc;\r\n\r\n--\r\n-- SQL_Plan\r\nset long 999999999\r\n\r\nSELECT t.*\r\nFROM gv$sql s, table(DBMS_XPLAN.DISPLAY_CURSOR(s.sql_id, s.child_number)) t\r\nWHERE s.sql_id='&sql_id';\r\n\r\nPROMPT\r\nPROMPT\r\nPROMPT +------------------------------------------------------------------------+\r\nPROMPT | STALE STATISTICS                                                       |\r\nPROMPT +------------------------------------------------------------------------+\r\n-- STALE STATISTICS\r\nset head on;\r\nset linesize 200\r\ncol table_owner for a15\r\ncol table_name for a25\r\ncol partition_name for a20\r\nselect distinct b.table_owner, b.table_name, b.partition_name, b.inserts, b.updates, b.deletes, b.TRUNCATED,c.STALE_STATS,\r\nto_char(b.timestamp, 'mm/dd/yyyy hh24:mi') timestamp, to_char(c.last_analyzed, 'mm/dd/yyyy hh24:mi') last_analyzed,\r\nc.num_rows\r\nfrom (select distinct sql_id, object#, object_name, object_owner from v$sql_plan where sql_id = '&sql_id' UNION select distinct sql_id, object#, object_name, object_owner from dba_hist_sql_plan where sql_id = '&sql_id') a\r\n, sys.dba_tab_modifications b, dba_tab_statistics c\r\nwhere a.sql_id = '&sql_id'\r\nand  a.OBJECT_OWNER = b.table_owner\r\nand  a.OBJECT_NAME = b.table_name\r\nand  b.table_owner = c.owner\r\nand  b.table_name  = c.table_name\r\nand  NVL(b.partition_name,'NONE') = NVL(c.partition_name,'NONE')\r\nand b.table_name is not null\r\norder by b.table_owner, b.table_name, b.partition_name;\r\n\r\nPROMPT\r\nPROMPT\r\nPROMPT +------------------------------------------------------------------------+\r\nPROMPT | FLUSH PLAN QUERY SYNTAX                                                |\r\nPROMPT +------------------------------------------------------------------------+\r\nselect 'exec sys.dbms_shared_pool.purge('''||address||','||hash_value||''',''c'',1);' Flush_Plan_Syntax  from v$sqlarea where sql_id like '&sql_id';\r\nPROMPT
31	All Session(Active+Inactive+Sys)	All Session(Active+Inactive+Sys) (all_sess_db)	--------------------------------------------------------------------------------------\r\n-- Show all Sessions along with their PID and Client Process IDs  with Summary\r\n--------------------------------------------------------------------------------------\r\n\r\n \r\n\r\nSET TERMOUT OFF;\r\nCOLUMN current_instance NEW_VALUE current_instance NOPRINT;\r\nCOLUMN db_unique_name NEW_VALUE db_unique_name NOPRINT;\r\nCOLUMN current_timestamp NEW_VALUE current_timestamp  NOPRINT;\r\nSELECT rpad(sys_context('USERENV', 'DB_UNIQUE_NAME'),15)  db_unique_name  FROM DUAL;\r\nSELECT rpad(instance_name, 17) current_instance,rpad(to_char(current_timestamp,'DD-MON-YY HH24:MI'),17) current_timestamp FROM v$instance;\r\nSET TERMOUT ON\r\n\r\nPROMPT\r\nPROMPT +------------------------------------------------------------------------+\r\nPROMPT   Report   : Show All Sessions\r\nPROMPT   DB_Name  : &db_unique_name\r\nPROMPT   Timestamp: &current_timestamp\r\nPROMPT +------------------------------------------------------------------------+\r\n\r\nset linesize 160\r\nset pagesize 100\r\nclear columns\r\nclear breaks\r\nttitle off\r\n\r\ncolumn usr                 format a17       Heading 'Osuser  /User'\r\ncolumn sid                 format 9999      heading 'S|I|D'\r\ncolumn connected           format A19       heading 'Connected'\r\ncolumn stat                format A1        heading 'S|t|a|t'\r\ncolumn serial              format 999999    heading 'Serial#'\r\ncolumn server              format 99999   heading 'PID'\r\ncolumn client              format 9999999  heading 'Clnt-Process'\r\ncolumn machine             format A20       heading 'Machine'\r\ncolumn module              format A30       heading 'Module'\r\ncolumn Instance            format A13       heading 'Inst|Sid,Serial#'\r\n\r\n\r\nset verify off\r\n\r\n-- Background processes\r\nSELECT rpad(S.OSUSER,8)||'/'||\r\n       substr(s.program,instr(s.program,' ')) Usr,\r\n       TO_CHAR(S.LOGON_TIME,'YYYY-MM-DD HH24:MI:SS') connected,\r\n\t   S.Inst_id||':'||S.SID||','||S.SERIAL# Instance,substr(S.STATUS,1,1) STAT, p.spid server, s.process client,\r\n       substr(S.MACHINE,1,20) MACHINE, substr(S.MODULE,1,30) module\r\n  FROM\r\n       GV$SESSION S,\r\n       GV$SESS_IO I,\r\n       V$PROCESS P\r\n WHERE\r\n       S.SID = I.SID\r\n\tAND S.INST_ID=I.INST_ID   \r\n   AND S.USER# = 0\r\n   AND S.PADDR = P.ADDR\r\n   AND (S.TYPE != 'USER' OR\r\n        S.TERMINAL IS NOT NULL OR\r\n        S.PROGRAM IS NOT NULL)\r\nUNION\r\n-- Snapshot refresh processes(also job queue processes)\r\nSELECT rpad(p.username,8)||'/'||\r\n       substr(p.program,instr(p.program,' ')) Usr,\r\n       TO_CHAR(S.LOGON_TIME,'YYYY-MM-DD HH24:MI:SS') connected,\r\n       S.Inst_id||':'||S.SID||','||S.SERIAL# Instance,substr(S.STATUS,1,1) STAT, p.spid server, s.process client,\r\n       substr(p.program,instr(p.program,'@')+1,\r\n              instr(p.program,' ')-instr(p.program,'@')) MACHINE,\r\n       substr(S.MODULE,1,30) module\r\n  FROM\r\n       GV$SESSION S,\r\n       GV$SESS_IO I, \r\n       V$PROCESS P\r\n WHERE\r\n       S.SID = I.SID\r\n   AND S.INST_ID=I.INST_ID\t   \r\n   AND S.USER# = 0\r\n   AND S.TYPE = 'USER'\r\n   AND S.TERMINAL IS NULL\r\n   AND S.PROGRAM IS NULL\r\n   AND S.PADDR = P.ADDR\r\nUNION\r\n-- Users\r\nSELECT rpad(S.OSUSER,8)||'/'||rpad(S.USERNAME,8) Usr,\r\n       TO_CHAR(S.LOGON_TIME,'YYYY-MM-DD HH24:MI:SS') connected,\r\n       S.Inst_id||':'||S.SID||','||S.SERIAL# Instance,substr(S.STATUS,1,1) STAT, p.spid server, s.process client,\r\n       substr(S.MACHINE,1,20) MACHINE, substr(S.MODULE,1,30) module\r\n  FROM\r\n       GV$SESSION S,\r\n       GV$SESS_IO I,\r\n       V$PROCESS P\r\n WHERE\r\n       S.SID = I.SID\r\n    AND S.INST_ID=I.INST_ID\t \t   \r\n   AND S.USER# != 0\r\n   AND S.PADDR = P.ADDR\r\n ORDER BY  2,4;\r\n\r\ncol total_sess format 9999\r\ncol host_name format a15\r\ncol inst_name format a6\r\nbreak on inst_name skip 1\r\nselect i.instance_name inst_name,i.host_name,s.status,count(*) total_sess from gv$session s,gv$instance i\r\nwhere i.inst_id=s.inst_id\r\ngroup by i.instance_name,i.host_name,s.status\r\norder by 1,2;
20	Session History(blocked/wait time)	Session History(blocked/wait time)	REM   Show session history of all sessions includes  blocked  or wait event \r\nSET TERMOUT OFF;\r\nCOLUMN current_instance NEW_VALUE current_instance NOPRINT;\r\nCOLUMN db_unique_name NEW_VALUE db_unique_name NOPRINT;\r\nCOLUMN current_timestamp NEW_VALUE current_timestamp  NOPRINT;\r\nSELECT rpad(sys_context('USERENV', 'DB_UNIQUE_NAME'),15)  db_unique_name  FROM DUAL;\r\nSELECT rpad(instance_name, 17) current_instance,rpad(to_char(current_timestamp,'DD-MON-YY HH24:MI'),17) current_timestamp FROM v$instance;\r\nSET TERMOUT ON\r\n\r\nPROMPT\r\nPROMPT +--------------------------------------------------------------------------------------+\r\nPROMPT   Report   : Session History Details(All Sessions)\r\nPROMPT   Duration : Between &2 and &3 \r\nPROMPT   DB_Name  : &db_unique_name\r\nPROMPT   Timestamp: &current_timestamp\r\nPROMPT +--------------------------------------------------------------------------------------+\r\n\r\n\r\n------------------------------------------------\r\n-- Show Active/Inactive Sessions for Only Users\r\n---------------------------------------------\r\nset linesize 180\r\nset pagesize 40\r\n--clear columns\r\n--clear breaks\r\ndefine input=&1\r\ndefine start_time=&2\r\ndefine end_time=&3\r\nttitle off\r\n\r\ncolumn usr                 format a11       Heading 'User'\r\ncolumn INSTANCE_NUMBER     format 9      heading 'I|N|S'\r\ncolumn SESSION_ID          format 9999      heading 'S|I|D'\r\ncolumn SQL_PLAN_HASH_VALUE format A10       heading 'SQL PLAN|HASH_VALUE'\r\ncolumn stat                format A1        heading 'S|t|a|t'\r\ncolumn serial              format 9999999   heading 'Serial#'\r\ncolumn machine             format A18       heading 'Machine'\r\ncolumn program             format A16       heading 'Program'\r\ncolumn physical_reads      format 999999999 heading 'Physical|Reads'\r\ncolumn chgs                format A9        heading 'Logical|  Chgs'\r\ncolumn Block_sess          format A6 heading 'Blk|sess'\r\ncolumn module              format A16       heading 'Module'\r\ncolumn Obj_name            format A24       heading 'Obj|Name'\r\ncolumn wait_class           format A10       heading 'Wait Class'\r\ncolumn Time_Waited          format A8       heading 'Time|Waited|Second'\r\ncolumn instance            format A12       heading 'Inst:|Sid,Serial#'\r\ncolumn sql_id              format A13       heading 'SQL ID'\r\n-- column SQL_CHILD_NUMBER  format   9999999       heading 'SQL Child'\r\ncolumn SESSION_STATE     format A9       heading 'Sess Stat'\r\ncolumn wait_events      format A19       heading 'Sess Event'\r\nset verify off\r\nSELECT s.INSTANCE_NUMBER||':'||S.SESSION_ID||','||S.SESSION_SERIAL# instance,U.USERNAME Usr,\r\n       TO_CHAR(S.SAMPLE_TIME,'YYYY-MM-DD HH24:MI') sample_time,\r\n       to_char(s.SQL_PLAN_HASH_VALUE) SQL_PLAN_HASH_VALUE,S.SQL_ID,o.owner||'.'||OBJECT_NAME Obj_name,\r\n substr(s.program,instr(s.program,'@')+1,\r\n              instr(s.program,' ')-instr(s.program,'@')) machine\r\n     ,substr(S.WAIT_CLASS,1,10) wait_class\r\n     ,substr(round(S.TIME_WAITED/1000000),1,10) Time_Waited\r\n\t,SESSION_STATE \r\n\t,event wait_events\r\n     ,to_char(BLOCKING_INST_ID)||':'||to_char(BLOCKING_SESSION) Block_sess\r\n  FROM\r\n       DBA_HIST_ACTIVE_SESS_HISTORY S,\r\n       DBA_USERS  U\r\n\t   ,dba_objects o\r\n WHERE\r\n       S.USER_ID = U.USER_ID\r\n       AND S.USER_ID != 0\r\n\t   and o.OBJECT_ID=s.CURRENT_OBJ# \r\n    and  s.sample_time >= to_timestamp('&&start_time', 'YYYY-MM-DD HH24:MI')\r\n    and s.sample_time <= to_timestamp('&&end_time', 'YYYY-MM-DD HH24:MI')\r\n   and (s.blocking_session is not null or s.wait_class is not null)\r\n  and round(S.TIME_WAITED/1000000) > 0\r\n   and ((to_char(s.SESSION_ID)='&input') or (upper(S.SQL_PLAN_HASH_VALUE) =upper('&input')) or (upper(U.USERNAME)=upper('&input')) or (upper(S.sql_id) like upper ('&&input%')) or (upper(o.object_name) = upper('&input')))\r\n ORDER BY sample_time,1,4,3;\r\nPROMPT +------------------------------------------------------------------------+\r\nPROMPT +-----------Objects involved during execution of query-------------------+\r\ncol obj_name for a40\r\ncol obj_type for a40\r\ncol owner for a25\r\ncol is_temp_table for a14 heading 'IS_TEMP|Table'\r\nSELECT distinct OWNER owner,OBJECT_NAME obj_name,OBJECT_TYPE obj_type,temporary is_temp_table\r\n   FROM\r\n       DBA_HIST_ACTIVE_SESS_HISTORY S,\r\n       DBA_USERS  U\r\n           ,dba_objects o\r\n WHERE\r\n       S.USER_ID = U.USER_ID\r\n       AND S.USER_ID != 0\r\n           and o.OBJECT_ID=s.CURRENT_OBJ#\r\n    and  s.sample_time >= to_timestamp('&&start_time', 'YYYY-MM-DD HH24:MI')\r\n    and s.sample_time <= to_timestamp('&&end_time', 'YYYY-MM-DD HH24:MI')\r\n   and ((to_char(s.SESSION_ID)='&input') or (upper(S.SQL_PLAN_HASH_VALUE) =upper('&input')) or (upper(U.USERNAME)=upper('&input')) or (upper(S.sql_id) like upper ('&&input%')) or (upper(o.object_name) = upper('&input')))\r\n/
33	Tablespace free space	Tablespace free space with autoextend(TABLESPACE)(tbs_free_autoextend)	SET TERMOUT OFF;\r\nCOLUMN current_instance NEW_VALUE current_instance NOPRINT;\r\nCOLUMN db_unique_name NEW_VALUE db_unique_name NOPRINT;\r\nCOLUMN current_timestamp NEW_VALUE current_timestamp  NOPRINT;\r\nSELECT rpad(sys_context('USERENV', 'DB_UNIQUE_NAME'),15)  db_unique_name  FROM DUAL;\r\nSELECT rpad(instance_name, 17) current_instance,rpad(to_char(current_timestamp,'DD-MON-YY HH24:MI'),17) current_timestamp FROM v$instance;\r\nSET TERMOUT ON\r\n\r\nPROMPT\r\nPROMPT +------------------------------------------+\r\nPROMPT   Report   : Tablespace Free Space Detail\r\nPROMPT   DB_Name  : &db_unique_name\r\nPROMPT   Timestamp: &current_timestamp\r\nPROMPT +------------------------------------------+\r\n\r\n\r\nREM Tablespace with autoextend \r\nREM REQUIRES:   dba_tablespaces, dba_data_files\r\nREM\r\nundefine tbs\r\ndefine tbs=&1\r\nCOLUMN tbs NEW_VALUE tbs NOPRINT;\r\nSET lines 140 pages 66 feedback off\r\nCOLUMN tablespace_name        format a25             heading 'Tablespace|(TBS)|Name'\r\nCOLUMN autoextensible         format a6              heading 'Can|Auto|Extend'\r\nCOLUMN files_in_tablespace    format 999             heading 'Files|In|TBS'\r\nCOLUMN total_tablespace_space format 99,999,999,999 heading 'Total|CurrentMB|TBS|Space'\r\nCOLUMN total_used_space       format 99,999,999,999 heading 'Total|CurrentMB|Used|Space'\r\nCOLUMN total_tablespace_free_space format 99,999,999,999 heading 'Total|CurrentMB|Free|Space'\r\nCOLUMN total_used_pct              format 999.99      heading 'Total|Current|UsedMB|(%)'\r\nCOLUMN pct_used_max              format 999.99      heading 'Max|Used|(%)'\r\nCOLUMN total_free_pct              format 999.99      heading 'Total|Current|FreeMB|(%)'\r\nCOLUMN max_size_of_tablespace      format 99,999,999 heading 'TBS|Max|SizeMB'\r\n--COLUMN total_auto_used_pct         format 999.99      heading 'Total|Max|Used|(%)'\r\nCOLUMN total_auto_used_pct         format 999.99      heading 'Total|Max|Free|(%)'\r\n--COLUMN total_auto_free_pct         format 999.99      heading 'Total|Max|Free|(%)'\r\nCOLUMN total_auto_free_pct         format 999.99      heading 'Total|Max|Used|(%)'\r\nSET VERIFY OFF\r\n\r\nSET TERMOUT ON\r\nTTITLE left _date center Tablespace_Space_Utilization_Status_Report skip 2\r\n\r\nWITH tbs_auto AS\r\n     (SELECT DISTINCT tablespace_name, autoextensible\r\n                 FROM dba_data_files \r\n                WHERE autoextensible = 'YES' and tablespace_name='&&tbs'),\r\n     files AS\r\n     (SELECT   tablespace_name, COUNT (*) tbs_files,\r\n               SUM (BYTES/1024/1024) total_tbs_bytes\r\n          FROM dba_data_files where tablespace_name='&&tbs'\r\n      GROUP BY tablespace_name),\r\n     fragments AS\r\n     (SELECT   tablespace_name, COUNT (*) tbs_fragments,\r\n               SUM (BYTES/1024/1024) total_tbs_free_bytes,\r\n               MAX (BYTES/1024/1024) max_free_chunk_bytes\r\n          FROM dba_free_space where tablespace_name='&&tbs'\r\n      GROUP BY tablespace_name),\r\n     AUTOEXTEND AS\r\n     (SELECT   tablespace_name, SUM (size_to_grow) total_growth_tbs\r\n          FROM (SELECT   tablespace_name, SUM (maxbytes/1024/1024) size_to_grow\r\n                    FROM dba_data_files\r\n                   WHERE autoextensible = 'YES' and tablespace_name='&&tbs'\r\n                GROUP BY tablespace_name\r\n                UNION\r\n                SELECT   tablespace_name, SUM (BYTES/1024/1024) size_to_grow\r\n                    FROM dba_data_files\r\n                   WHERE autoextensible = 'NO' AND tablespace_name='&&tbs'\r\n                GROUP BY tablespace_name)\r\n      GROUP BY tablespace_name)\r\nSELECT a.tablespace_name,\r\n       CASE tbs_auto.autoextensible\r\n          WHEN 'YES'\r\n             THEN 'YES'\r\n          ELSE 'NO'\r\n       END AS autoextensible,\r\n       files.tbs_files files_in_tablespace,\r\n       files.total_tbs_bytes total_tablespace_space,\r\n       (files.total_tbs_bytes - fragments.total_tbs_free_bytes\r\n       ) total_used_space,\r\n       fragments.total_tbs_free_bytes total_tablespace_free_space,\r\n       (  (  (files.total_tbs_bytes - fragments.total_tbs_free_bytes)\r\n           / files.total_tbs_bytes\r\n          )\r\n        * 100\r\n       ) total_used_pct,\r\n       ((fragments.total_tbs_free_bytes / files.total_tbs_bytes) * 100\r\n       ) total_free_pct,\r\n       AUTOEXTEND.total_growth_tbs max_size_of_tablespace\r\n      ,(files.total_tbs_bytes - fragments.total_tbs_free_bytes\r\n       )*100/AUTOEXTEND.total_growth_tbs pct_used_max\r\n      , round(fragments.total_tbs_free_bytes/1024) free_max_gb\r\n /*       (  (  (  AUTOEXTEND.total_growth_tbs\r\n              - (AUTOEXTEND.total_growth_tbs - fragments.total_tbs_free_bytes\r\n                )\r\n             )\r\n           / AUTOEXTEND.total_growth_tbs\r\n          )\r\n        * 100\r\n       ) total_auto_used_pct */\r\n/*\r\n       (  (  (AUTOEXTEND.total_growth_tbs - fragments.total_tbs_free_bytes)\r\n           / AUTOEXTEND.total_growth_tbs\r\n          )\r\n        * 100\r\n       ) total_auto_free_pct */ \r\n  FROM dba_tablespaces a, files, fragments, AUTOEXTEND, tbs_auto\r\n WHERE a.tablespace_name = files.tablespace_name\r\n   AND a.tablespace_name = fragments.tablespace_name\r\n   AND a.tablespace_name = AUTOEXTEND.tablespace_name\r\n   AND a.tablespace_name = tbs_auto.tablespace_name(+)\r\n   AND a.tablespace_name  = '&&tbs';\r\n---\r\ncolumn name format a15\r\ncolumn variance format a20\r\ncolumn alloc_size_gb format 99999.9 heading 'Alloc_Size|GB'\r\ncolumn prev_used_size_gb format 99999.9 heading 'Prev_Used|Size GB'\r\ncolumn curr_used_size_gb format 99999.9 heading 'Used_Size|GB'\r\nalter session set nls_date_format='yyyy-mm-dd';\r\nwith t as (\r\nselect ss.run_time,ts.name,round(su.tablespace_size*dt.block_size/1024/1024/1024,2) alloc_size_gb,\r\nround(su.tablespace_usedsize*dt.block_size/1024/1024/1024,2) used_size_gb\r\nfrom\r\ndba_hist_tbspc_space_usage su,\r\n(select trunc(BEGIN_INTERVAL_TIME) run_time,max(snap_id) snap_id from dba_hist_snapshot\r\ngroup by trunc(BEGIN_INTERVAL_TIME) ) ss,\r\nv$tablespace ts,\r\ndba_tablespaces dt\r\nwhere su.snap_id = ss.snap_id\r\nand   su.tablespace_id = ts.ts#\r\nand   ts.name          =upper('&&tbs')\r\nand   ts.name          = dt.tablespace_name )\r\nselect e.run_time,e.name,e.alloc_size_gb,e.used_size_gb curr_used_size_gb,b.used_size_gb prev_used_size_gb,\r\ncase when e.used_size_gb > b.used_size_gb then to_char(e.used_size_gb - b.used_size_gb)\r\n     when e.used_size_gb = b.used_size_gb then '***NO DATA GROWTH'\r\n     when e.used_size_gb < b.used_size_gb then '******DATA PURGED' end variance\r\nfrom t e, t b\r\nwhere e.run_time = b.run_time + 1\r\norder by 1;\r\n---\r\nTTITLE OFF\r\nPROMPT\r\nPROMPT +---------------------------+\r\nPROMPT | Datafiles of Tablespace                                                |\r\nPROMPT +---------------------------+\r\nCOLUMN size_mb format 99,999,999 heading 'Total|UsedMB'\r\nCOLUMN max_mb format 99,999,999 heading 'Total|MaxMB'\r\ncol auto_exnd for a5 heading 'Auto|Extnd'\r\ncol file_name format a70\r\nselect file_id,file_name,maxbytes/1024/1024 max_mb, bytes/1024/1024 size_mb,autoextensible  auto_exnd from dba_data_files\r\nwhere tablespace_name='&&tbs'\r\norder by 1;\r\n\r\nSET TERMOUT OFF;\r\nCOLUMN current_instance NEW_VALUE current_instance NOPRINT;\r\nCOLUMN hostname NEW_VALUE hostname;\r\nSELECT rpad(sys_context('USERENV', 'INSTANCE_NAME'), 17) current_instance,sys_context('USERENV', 'SERVER_HOST') hostname FROM dual;\r\nSET TERMOUT ON;\r\n\r\nPROMPT\r\nPROMPT +--------------------------------+\r\nPROMPT   Report   : ASM Disk Group                                               \r\nPROMPT   Instance : &current_instance                                            \r\nPROMPT   Host\t   : &hostname                                                    \r\nPROMPT +--------------------------------+\r\n\r\nSET ECHO        OFF\r\nSET FEEDBACK    6\r\nSET HEADING     ON\r\nSET LINESIZE    180\r\nSET PAGESIZE    50000\r\nSET TERMOUT     ON\r\nSET TIMING      OFF\r\nSET TRIMOUT     ON\r\nSET TRIMSPOOL   ON\r\nSET VERIFY      OFF\r\n\r\n--CLEAR COLUMNS\r\n--CLEAR BREAKS\r\nCLEAR COMPUTES\r\n\r\nCOLUMN group_name             FORMAT a30           HEAD 'Disk Group|Name'\r\nCOLUMN sector_size            FORMAT 99,999        HEAD 'Sector|Size'\r\nCOLUMN block_size             FORMAT 99,999        HEAD 'Block|Size'\r\n--COLUMN allocation_unit_size   FORMAT 999,999,999   HEAD 'Allocation|Unit Size'\r\nCOLUMN state                  FORMAT a11           HEAD 'State'\r\nCOLUMN type                   FORMAT a6            HEAD 'Type'\r\nCOLUMN total_gb               FORMAT 999,999,999   HEAD 'Total Size (GB)'\r\nCOLUMN used_gb                FORMAT 999,999,999   HEAD 'Used Size (GB)'\r\nCOLUMN free_gb                FORMAT 999,999,999   HEAD 'Free Size (GB)'\r\nCOLUMN pct_used               FORMAT 999.99        HEAD '(%)Used'\r\n\r\n--BREAK ON report ON disk_group_name SKIP 1\r\n\r\n--COMPUTE sum LABEL "Grand Total: " OF total_mb used_mb ON report\r\n\r\nSELECT\r\n    name                                     group_name\r\n--  , sector_size                              sector_size\r\n , block_size                               block_size\r\n -- , allocation_unit_size                     allocation_unit_size\r\n  , state                                    state\r\n  , type                                     type\r\n  , total_mb/1024                                 total_gb\r\n  , (total_mb - free_mb)/1024                     used_gb\r\n  , free_mb/1024                             free_gb\r\n  , ROUND((1- (free_mb / total_mb))*100, 2)  pct_used\r\nFROM\r\n    v$asm_diskgroup\r\nWHERE\r\n    total_mb != 0 and upper(name) \r\n    in ( \r\nselect distinct\r\ncase when instr(FILE_NAME,'/')>1\r\n     then substr(FILE_NAME,2,instr(FILE_NAME,'/')-2)\r\n     else FILE_NAME end\r\nTBS_DG_NAME  from dba_data_files where tablespace_name='&&tbs')\r\n/
15	Blocking  sessions	Show All Blocking if exist (blockers_rac)	SET TERMOUT OFF;\r\nCOLUMN current_instance NEW_VALUE current_instance NOPRINT;\r\nCOLUMN db_unique_name NEW_VALUE db_unique_name NOPRINT;\r\nCOLUMN current_timestamp NEW_VALUE current_timestamp  NOPRINT;\r\nSELECT rpad(sys_context('USERENV', 'DB_UNIQUE_NAME'),15)  db_unique_name  FROM DUAL;\r\nSELECT rpad(instance_name, 17) current_instance,rpad(current_timestamp,22) current_timestamp FROM v$instance;\r\nSET TERMOUT ON\r\n\r\nPROMPT\r\nPROMPT\r\nPROMPT +------------------------------------------------------------------------+\r\nPROMPT | Report   : Blocking/Locks                                              |\r\nPROMPT | DB_Name  : &db_unique_name                                             |\r\nPROMPT | Timestamp: &current_timestamp                                        |\r\nPROMPT +------------------------------------------------------------------------+\r\nPROMPT\r\n\r\nSET ECHO        OFF\r\nSET FEEDBACK    6\r\nSET HEADING     ON\r\nSET LINESIZE    256\r\nSET PAGESIZE    50000\r\nSET TERMOUT     ON\r\nSET TIMING      OFF\r\nSET TRIMOUT     ON\r\nSET TRIMSPOOL   ON\r\nSET VERIFY      OFF\r\n\r\nCLEAR COLUMNS\r\nCLEAR BREAKS\r\nCLEAR COMPUTES\r\n\r\nCOLUMN waiting_instance_sid_serial  FORMAT a24          HEADING '[WAITING]|Instance - SID / Serial#'\r\nCOLUMN waiting_oracle_username      FORMAT a20          HEADING '[WAITING]|Oracle User'\r\nCOLUMN waiting_pid                  FORMAT a11          HEADING '[WAITING]|PID'\r\nCOLUMN waiting_machine              FORMAT a15          HEADING '[WAITING]|Machine'   TRUNC\r\nCOLUMN waiting_os_username          FORMAT a15          HEADING '[WAITING]|O/S User'\r\nCOLUMN waiter_lock_type_mode_req    FORMAT a35          HEADING 'Waiter Lock Type / Mode Requested'\r\nCOLUMN waiting_lock_time_min        FORMAT a10          HEADING '[WAITING]|Lock Time'\r\nCOLUMN waiting_instance_sid         FORMAT a15          HEADING '[WAITING]|Instance - SID'\r\nCOLUMN waiting_sql_text             FORMAT a105         HEADING '[WAITING]|SQL Text'    WRAP\r\n\r\nCOLUMN locking_instance_sid_serial  FORMAT a24          HEADING '[LOCKING]|Instance - SID / Serial#'\r\nCOLUMN locking_oracle_username      FORMAT a20          HEADING '[LOCKING]|Oracle User'\r\nCOLUMN locking_pid                  FORMAT a11          HEADING '[LOCKING]|PID'\r\nCOLUMN locking_machine              FORMAT a15          HEADING '[LOCKING]|Machine'   TRUNC\r\nCOLUMN locking_os_username          FORMAT a15          HEADING '[LOCKING]|O/S User'\r\nCOLUMN locking_lock_time_min        FORMAT a10          HEADING '[LOCKING]|Lock Time'\r\n\r\nCOLUMN instance_name                FORMAT a6           HEADING 'Inst|Name'\r\nCOLUMN sid                          FORMAT 9999       HEADING 'SID'\r\nCOLUMN session_status               FORMAT a9           HEADING 'Status'\r\nCOLUMN locking_oracle_user          FORMAT a15          HEADING 'Locking | Oracle User'\r\nCOLUMN locking_os_user              FORMAT a15          HEADING 'Locking| O/S User'\r\nCOLUMN locking_os_pid               FORMAT a7          HEADING 'Locking|PID'\r\nCOLUMN locking_machine              FORMAT a15          HEADING 'Locking Machine'   TRUNC\r\nCOLUMN object_owner                 FORMAT a15          HEADING 'Object Owner'\r\nCOLUMN object_name                  FORMAT a25          HEADING 'Object Name'\r\nCOLUMN object_type                  FORMAT a15          HEADING 'Object Type'\r\nCOLUMN locked_mode                                      HEADING 'Locked Mode'\r\n\r\nCLEAR BREAKS\r\ncol current_time for a25\r\nSELECT systimestamp current_time FROM DUAL;\r\n\r\nPROMPT\r\nPROMPT\r\nPROMPT +------------------------------------------------------------------------+\r\nPROMPT | BLOCKING LOCKS (Summary)                                               |\r\nPROMPT +------------------------------------------------------------------------+\r\n\r\nSELECT\r\n    iw.instance_name || ' - ' || lw.sid || ' / ' || sw.serial#  waiting_instance_sid_serial\r\n  , sw.username                                                 waiting_oracle_username\r\n  , ROUND(lw.ctime/60) || ' min.'                               waiting_lock_time_min\r\n  , DECODE (   lh.type\r\n             , 'CF', 'Control File'\r\n             , 'DX', 'Distributed Transaction'\r\n             , 'FS', 'File Set'\r\n             , 'IR', 'Instance Recovery'\r\n             , 'IS', 'Instance State'\r\n             , 'IV', 'Libcache Invalidation'\r\n             , 'LS', 'Log Start or Log Switch'\r\n             , 'MR', 'Media Recovery'\r\n             , 'RT', 'Redo Thread'\r\n             , 'RW', 'Row Wait'\r\n             , 'SQ', 'Sequence Number'\r\n             , 'ST', 'Diskspace Transaction'\r\n             , 'TE', 'Extend Table'\r\n             , 'TT', 'Temp Table'\r\n             , 'TX', 'Transaction'\r\n             , 'TM', 'DML'\r\n             , 'UL', 'PLSQL User_lock'\r\n             , 'UN', 'User Name'\r\n             , 'Nothing-'\r\n           ) || ' / ' ||\r\n    DECODE (   lw.request\r\n             , 0, 'None'                        /* Mon Lock equivalent */\r\n             , 1, 'NoLock'                      /* N */\r\n             , 2, 'Row-Share (SS)'              /* L */\r\n             , 3, 'Row-Exclusive (SX)'          /* R */\r\n             , 4, 'Share-Table'                 /* S */\r\n             , 5, 'Share-Row-Exclusive (SSX)'   /* C */\r\n             , 6, 'Exclusive'                   /* X */\r\n             ,    '[Nothing]'\r\n           )                                                            waiter_lock_type_mode_req\r\n  , ih.instance_name || ' - ' || lh.sid || ' / ' || sh.serial#          locking_instance_sid_serial\r\n  , sh.username                                                         locking_oracle_username\r\n  , ROUND(lh.ctime/60) || ' min.'                                       locking_lock_time_min\r\nFROM\r\n    gv$lock     lw\r\n  , gv$lock     lh\r\n  , gv$instance iw\r\n  , gv$instance ih\r\n  , gv$session  sw\r\n  , gv$session  sh\r\nWHERE\r\n      iw.inst_id  = lw.inst_id\r\n  AND ih.inst_id  = lh.inst_id\r\n  AND sw.inst_id  = lw.inst_id\r\n  AND sh.inst_id  = lh.inst_id\r\n  AND sw.sid      = lw.sid\r\n  AND sh.sid      = lh.sid\r\n  AND lh.id1      = lw.id1\r\n  AND lh.id2      = lw.id2\r\n  AND lh.request  = 0\r\n  AND lw.lmode    = 0\r\n  AND (lh.id1, lh.id2) IN ( SELECT id1,id2\r\n                            FROM   gv$lock\r\n                            WHERE  request = 0\r\n                            INTERSECT\r\n                            SELECT id1,id2\r\n                            FROM   gv$lock\r\n                            WHERE  lmode = 0\r\n                          )\r\nORDER BY\r\n    iw.instance_name\r\n  , lw.sid;\r\n\r\n\r\nPROMPT\r\nPROMPT\r\nPROMPT +------------------------------------------------------------------------+\r\nPROMPT | BLOCKING LOCKS (User Details)                                          |\r\nPROMPT +------------------------------------------------------------------------+\r\n\r\nSELECT\r\n    iw.instance_name || ' - ' || lw.sid || ' / ' || sw.serial#          waiting_instance_sid_serial\r\n  , sw.username                                                         waiting_oracle_username\r\n  , sw.osuser                                                           waiting_os_username\r\n  , sw.machine                                                          waiting_machine\r\n  , pw.spid                                                             waiting_pid\r\n  , ih.instance_name || ' - ' || lh.sid || ' / ' || sh.serial#          locking_instance_sid_serial\r\n  , sh.username                                                         locking_oracle_username\r\n  , sh.osuser                                                           locking_os_username\r\n  , sh.machine                                                          locking_machine\r\n  , ph.spid                                                             locking_pid\r\nFROM\r\n    gv$lock     lw\r\n  , gv$lock     lh\r\n  , gv$instance iw\r\n  , gv$instance ih\r\n  , gv$session  sw\r\n  , gv$session  sh\r\n  , gv$process  pw\r\n  , gv$process  ph\r\nWHERE\r\n      iw.inst_id  = lw.inst_id\r\n  AND ih.inst_id  = lh.inst_id\r\n  AND sw.inst_id  = lw.inst_id\r\n  AND sh.inst_id  = lh.inst_id\r\n  AND pw.inst_id  = lw.inst_id\r\n  AND ph.inst_id  = lh.inst_id\r\n  AND sw.sid      = lw.sid\r\n  AND sh.sid      = lh.sid\r\n  AND lh.id1      = lw.id1\r\n  AND lh.id2      = lw.id2\r\n  AND lh.request  = 0\r\n  AND lw.lmode    = 0\r\n  AND (lh.id1, lh.id2) IN ( SELECT id1,id2\r\n                            FROM   gv$lock\r\n                            WHERE  request = 0\r\n                            INTERSECT\r\n                            SELECT id1,id2\r\n                            FROM   gv$lock\r\n                            WHERE  lmode = 0\r\n                          )\r\n  AND sw.paddr  = pw.addr (+)\r\n  AND sh.paddr  = ph.addr (+)\r\nORDER BY\r\n    iw.instance_name\r\n  , lw.sid;\r\n\r\n\r\nPROMPT\r\nPROMPT\r\nPROMPT +------------------------------------------------------------------------+\r\nPROMPT | BLOCKING LOCKS (Waiting SQL)                                           |\r\nPROMPT +------------------------------------------------------------------------+\r\n\r\nSELECT\r\n    iw.instance_name || ' - ' || lw.sid || ' / ' || sw.serial#    waiting_instance_sid_serial\r\n  , aw.sql_text                                                   waiting_sql_text\r\nFROM\r\n    gv$lock     lw\r\n  , gv$lock     lh\r\n  , gv$instance iw\r\n  , gv$instance ih\r\n  , gv$session  sw\r\n  , gv$session  sh\r\n  , gv$sqlarea  aw\r\nWHERE\r\n      iw.inst_id  = lw.inst_id\r\n  AND ih.inst_id  = lh.inst_id\r\n  AND sw.inst_id  = lw.inst_id\r\n  AND sh.inst_id  = lh.inst_id\r\n  AND aw.inst_id  = lw.inst_id\r\n  AND sw.sid      = lw.sid\r\n  AND sh.sid      = lh.sid\r\n  AND lh.id1      = lw.id1\r\n  AND lh.id2      = lw.id2\r\n  AND lh.request  = 0\r\n  AND lw.lmode    = 0\r\n  AND (lh.id1, lh.id2) IN ( SELECT id1,id2\r\n                            FROM   gv$lock\r\n                            WHERE  request = 0\r\n                            INTERSECT\r\n                            SELECT id1,id2\r\n                            FROM   gv$lock\r\n                            WHERE  lmode = 0\r\n                          )\r\n  AND sw.sql_address  = aw.address\r\nORDER BY\r\n    iw.instance_name\r\n  , lw.sid;\r\n\r\n\r\nPROMPT\r\nPROMPT\r\nPROMPT +------------------------------------------------------------------------+\r\nPROMPT | LOCKED OBJECTS                                                         |\r\nPROMPT +------------------------------------------------------------------------+\r\n\r\nSELECT\r\n    i.instance_name           instance_name\r\n  , l.session_id              sid\r\n  , s.status                  session_status\r\n  , l.oracle_username         locking_oracle_user\r\n  , s.osuser                  locking_os_user\r\n  , s.machine                 locking_machine\r\n  , p.spid                    locking_os_pid\r\n  , o.owner                   object_owner\r\n  , o.object_name             object_name\r\n  , o.object_type             object_type\r\n  , DECODE (   l.locked_mode\r\n             , 0, 'None'                        /* Mon Lock equivalent */\r\n             , 1, 'NoLock'                      /* N */\r\n             , 2, 'Row-Share (SS)'              /* L */\r\n             , 3, 'Row-Exclusive (SX)'          /* R */\r\n             , 4, 'Share-Table'                 /* S */\r\n             , 5, 'Share-Row-Exclusive (SSX)'   /* C */\r\n             , 6, 'Exclusive'                   /* X */\r\n             ,    '[Nothing]'\r\n           )                  locked_mode\r\nFROM\r\n    dba_objects       o\r\n  , gv$session        s\r\n  , gv$process        p\r\n  , gv$locked_object  l\r\n  , gv$instance       i\r\nWHERE\r\n      i.inst_id     = l.inst_id\r\n  AND s.inst_id     = l.inst_id\r\n  AND s.inst_id     = p.inst_id\r\n  AND s.sid         = l.session_id\r\n  AND o.object_id   = l.object_id\r\n  AND s.paddr       = p.addr\r\nORDER BY\r\n    i.instance_name\r\n  , l.session_id;
30	Active DML Session	DML-Active Session(rac_long_run_txn)	SET TERMOUT OFF;\r\nCOLUMN current_instance NEW_VALUE current_instance NOPRINT;\r\nCOLUMN db_unique_name NEW_VALUE db_unique_name NOPRINT;\r\nCOLUMN current_timestamp NEW_VALUE current_timestamp  NOPRINT;\r\nSELECT rpad(sys_context('USERENV', 'DB_UNIQUE_NAME'),15)  db_unique_name  FROM DUAL;\r\nSELECT rpad(instance_name, 17) current_instance,rpad(to_char(current_timestamp,'DD-MON-YY HH24:MI'),17) current_timestamp FROM v$instance;\r\nSET TERMOUT ON\r\n\r\nPROMPT\r\nPROMPT +----------------------------------------------------------+\r\nPROMPT   Report   : DML Active sessions   \r\nPROMPT   DB_Name  : &db_unique_name \r\nPROMPT   Timestamp: &current_timestamp\r\nPROMPT +----------------------------------------------------------+\r\n\r\n-- Query : rac_long_run_txn.sql \r\n-- The following query (to be run by a DBA) lists for currently \r\n-- active transactions who is running them (username + program \r\n-- info when available, complete with session id ready to be used \r\n-- in an 'ALTER SYSTEM KILL SESSION' command), the text of the \r\n-- associated SQL query, how many rollback segment blocks we have\r\n-- used so far and for how long the transaction has been running\r\n-- (in seconds), and the name of the table(s) on which the running\r\n-- transaction has put row-locks. \r\n--\r\n-- Note that some innocent-looking UPDATE can indeed put row-locks\r\n-- on many tables if there are triggers updating, inserting or\r\n-- deleting other tables. Transactions are ordered by duration \r\n-- (transactions which have been running the longer first). \r\n-- \r\n-- This is quite useful for monitoring long-running updates and \r\n-- locking problems. \r\nPROMPT\r\nPROMPT +------------------------------------------------+\r\nPROMPT   DML Long Running Transactions\r\nPROMPT +------------------------------------------------+\r\nPROMPT\r\n\r\nset pagesize 2000\r\nset linesize 200\r\nset recsep off \r\ncolumn "WHO" format A37 \r\ncolumn "TABLE" format A20 \r\ncolumn "TEXT" format A45 word_wrapped \r\ncolumn "RB BLKS/S RUNNING" format A14 head 'RB BLKS|S Running' \r\nclear breaks \r\nbreak on "WHO" on "ROLLBACK BLOCKS" on "RB BLKS/S RUNNING" on "TEXT" skip 1 \r\nselect to_char(se.sid ) || ',' || to_char(se.serial#) || '@' ||to_char(se.inst_id)||' '|| se.username || \r\n       '/' ||decode(ltrim(se.module || ' ' || se.action || ' ' || se.client_info),\r\n       '', se.program,ltrim(se.module || ' ' || se.action || ' ' || se.client_info)) "WHO",\r\n       s.sql_text "TEXT",to_char(x.used_ublk )||'/'|| to_char((sysdate-to_date(x.start_time,\r\n      'MM/DD/RR HH24:MI:SS'))*86400) "RB BLKS/S RUNNING",o.name "TABLE" \r\nfrom gv$sqlarea s,\r\n     gv$session se,\r\n     sys.obj$ o,\r\n     gv$locked_object l,\r\n     gv$transaction x,\r\n     gv$lock l2 \r\nwhere \r\n  s.inst_id=se.inst_id\r\n  and se.inst_id=l.inst_id\r\n  and se.inst_id=x.inst_id\r\n  and se.inst_id=l2.inst_id\r\n  and se.sql_address = s.address \r\n  and x.ses_addr = se.saddr \r\n  and o.obj# = l.object_id \r\n  and l.xidusn = x.xidusn \r\n  and l.xidslot = x.xidslot \r\n  and l.xidsqn = x.xidsqn \r\n  and l2.id2 = x.xidsqn \r\n  and l2.id1 = 65536 * x.xidusn + x.xidslot \r\n  and l2.type = 'TX' \r\norder by (sysdate-to_date(x.start_time,'MM/DD/RR HH24:MI:SS'))*86400 desc,1,4;
35	Undo space	Undo space (undo_details)	SET TERMOUT OFF;\r\nCOLUMN current_instance NEW_VALUE current_instance NOPRINT;\r\nCOLUMN db_unique_name NEW_VALUE db_unique_name NOPRINT;\r\nCOLUMN current_timestamp NEW_VALUE current_timestamp  NOPRINT;\r\nSELECT rpad(sys_context('USERENV', 'DB_UNIQUE_NAME'),15)  db_unique_name  FROM DUAL;\r\nSELECT rpad(instance_name, 17) current_instance,rpad(to_char(current_timestamp,'DD-MON-YY HH24:MI'),17) current_timestamp FROM v$instance;\r\nSET TERMOUT ON\r\n\r\nPROMPT\r\nPROMPT +--------------------------------+\r\nPROMPT   Report   : Undo Space detail\r\nPROMPT   DB_Name  : &db_unique_name\r\nPROMPT   Timestamp: &current_timestamp\r\nPROMPT +--------------------------------+\r\n\r\nset linesize 200\r\nset pagesize 200\r\ncol tablespace_name for a20\r\ncol size_gb for 999,999.9\r\nselect tablespace_name, round(sum(bytes/1024/1024/1024),2) size_gb, status, sum(blocks) sum_blks\r\nfrom dba_undo_extents group by status,tablespace_name order by tablespace_name, status;\r\n\r\nPROMPT +------------+\r\nPROMPT   UNDO USAGE\r\nPROMPT +------------+\r\nselect a.tablespace_name, round(SIZEGB,2) SIZE_GB, round(USAGEGB,2) USED_GB, round((SIZEGB-USAGEGB),2) FREE_GB\r\nfrom (select sum(bytes)/1024/1024/1024 SIZEGB, b.tablespace_name\r\nfrom dba_data_files a, dba_tablespaces b\r\nwhere a.tablespace_name = b.tablespace_name\r\nand b.contents = 'UNDO'\r\ngroup by b.tablespace_name) a,\r\n(select c.tablespace_name, sum(bytes)/1024/1024/1024 USAGEGB\r\nfrom DBA_UNDO_EXTENTS c\r\nwhere status <> 'EXPIRED'\r\ngroup by c.tablespace_name) b\r\nwhere a.tablespace_name = b.tablespace_name;\r\n\r\nPROMPT +------------+\r\nPROMPT   UNDO RECOVER\r\nPROMPT +------------+\r\ncol etime heading "Estimated time | to complete"\r\ncol usn heading "Undo seg|num"\r\nalter session set NLS_DATE_FORMAT='DD-MON-YYYY HH24:MI:SS';\r\nselect usn, state, undoblockstotal "Total", undoblocksdone "Done", undoblockstotal-undoblocksdone "ToDo",\r\ndecode(cputime,0,'unknown',sysdate+(((undoblockstotal-undoblocksdone) / (undoblocksdone / cputime)) / 86400)) etime\r\nfrom v$fast_start_transactions;\r\n\r\ncol sid_serial for a10\r\ncol Undo_usage for  a12\r\ncol orauser for  a20\r\ncol inst_id for 9999 heading 'Inst'\r\n\r\n\r\nPROMPT +---------------+\r\nPROMPT   UNDO SESSIONS\r\nPROMPT +---------------+\r\nSELECT s.Inst_id,TO_CHAR (s.SID) || ',' || TO_CHAR (s.serial#) sid_serial,\r\nNVL (s.username, 'None') orauser,round(t.used_ublk * TO_NUMBER (x.VALUE) / 1024/1024,2) || 'M' "Undo_usage", s.status\r\n,to_char(t.START_DATE,'DD-MON-YYYY HH24:MI') trns_start_date,SQL_ID,PREV_SQL_ID,SQL_HASH_VALUE,substr(SERVICE_NAME,1,20) service_name\r\nFROM SYS.v_$rollname r,\r\nSYS.gv_$session s,\r\nSYS.gv_$transaction t,\r\nSYS.gv_$parameter x\r\nWHERE s.taddr = t.addr and s.inst_id=t.inst_id and s.inst_id=x.inst_id\r\nAND r.usn = t.xidusn(+) \r\nAND x.NAME = 'db_block_size'\r\nORDER BY round(t.used_ublk * TO_NUMBER (x.VALUE) / 1024/1024,2) desc;
36	ASM DiskGroup Details	ASM DiskGroup Details (asm_diskgroups)	SET TERMOUT OFF;\r\nCOLUMN current_instance NEW_VALUE current_instance NOPRINT;\r\nSELECT rpad(sys_context('USERENV', 'INSTANCE_NAME'), 17) current_instance FROM dual;\r\nSET TERMOUT ON;\r\n\r\nPROMPT \r\nPROMPT +------------------------------------------------------------------------+\r\nPROMPT | Report   : ASM Disk Groups                                             |\r\nPROMPT | Instance : &current_instance                                           |\r\nPROMPT +------------------------------------------------------------------------+\r\n\r\nSET ECHO        OFF\r\nSET FEEDBACK    6\r\nSET HEADING     ON\r\nSET LINESIZE    180\r\nSET PAGESIZE    50000\r\nSET TERMOUT     ON\r\nSET TIMING      OFF\r\nSET TRIMOUT     ON\r\nSET TRIMSPOOL   ON\r\nSET VERIFY      OFF\r\n\r\nCLEAR COLUMNS\r\nCLEAR BREAKS\r\nCLEAR COMPUTES\r\n\r\nCOLUMN group_name             FORMAT a35           HEAD 'Disk Group|Name'\r\nCOLUMN sector_size            FORMAT 99,999        HEAD 'Sector|Size'\r\nCOLUMN block_size             FORMAT 99,999        HEAD 'Block|Size'\r\nCOLUMN allocation_unit_size   FORMAT 999,999,999   HEAD 'Allocation|Unit Size'\r\nCOLUMN state                  FORMAT a11           HEAD 'State'\r\nCOLUMN type                   FORMAT a6            HEAD 'Type'\r\nCOLUMN total_mb               FORMAT 999,999,999   HEAD 'Total Size (MB)'\r\nCOLUMN used_mb                FORMAT 999,999,999   HEAD 'Used Size (MB)'\r\nCOLUMN free_mb                FORMAT 999,999,999   HEAD 'Free(MB)'\r\nCOLUMN pct_used               FORMAT 999.99        HEAD 'Pct. Used'\r\n\r\nBREAK ON report ON disk_group_name SKIP 1\r\n\r\nCOMPUTE sum LABEL "Grand Total: " OF total_mb used_mb ON report\r\n\r\nSELECT\r\n    name                                     group_name\r\n -- , sector_size                              sector_size\r\n  , block_size                               block_size\r\n--  , allocation_unit_size                     allocation_unit_size\r\n  , state                                    state\r\n  , type                                     type\r\n  , total_mb                                 total_mb\r\n  , (total_mb - free_mb)                     used_mb\r\n  , free_mb                                  free_mb\r\n  , ROUND((1- (free_mb / total_mb))*100, 2)  pct_used\r\nFROM\r\n    v$asm_diskgroup\r\nWHERE\r\n    total_mb != 0\r\nORDER BY\r\n    name\r\n/
22	Session history include execution details	session history include execution details	set markup html on\r\nSET TERMOUT OFF;\r\nCOLUMN current_instance NEW_VALUE current_instance NOPRINT;\r\nCOLUMN db_unique_name NEW_VALUE db_unique_name NOPRINT;\r\nCOLUMN current_timestamp NEW_VALUE current_timestamp  NOPRINT;\r\nSELECT rpad(sys_context('USERENV', 'DB_UNIQUE_NAME'),15)  db_unique_name  FROM DUAL;\r\nSELECT rpad(instance_name, 17) current_instance,rpad(to_char(current_timestamp,'DD-MON-YY HH24:MI'),17) current_timestamp FROM v$instance;\r\nSET TERMOUT ON\r\n\r\n \r\nPROMPT\r\nPROMPT +--------------------------------------------------------------------------------------+\r\nPROMPT   Report   : Session History include execution detail(From &2 to &3)\r\nPROMPT   Option   : &1 \r\nPROMPT   DB_Name  : &db_unique_name\r\nPROMPT   Timestamp: &current_timestamp\r\nPROMPT +--------------------------------------------------------------------------------------+\r\n\r\n\r\nset linesize 180\r\nset pagesize 40\r\n--clear columns\r\n--clear breaks\r\ndefine input=&1\r\ndefine start_time=&2\r\ndefine end_time=&3\r\nttitle off\r\n\r\ncolumn usr                 format a11       Heading 'User'\r\ncolumn INSTANCE_NUMBER     format 9      heading 'I|N|S'\r\ncolumn SESSION_ID          format 9999      heading 'S|I|D'\r\ncolumn SQL_PLAN_HASH_VALUE format A10       heading 'SQL PLAN|HASH_VALUE'\r\ncolumn stat                format A1        heading 'S|t|a|t'\r\ncolumn sess_stat\t   format A9        heading 'Sess|Stat'\r\ncolumn serial              format 9999999   heading 'Serial#'\r\ncolumn machine             format A18       heading 'Machine'\r\ncolumn program             format A16       heading 'Program'\r\ncolumn Hard_Parse          format A5        heading 'Hard|Prase'\r\ncolumn Block_sess          format A6 heading 'Blk|sess'\r\ncolumn module              format A16       heading 'Module'\r\ncolumn Obj_name            format A22       heading 'Obj|Name'\r\ncolumn wait_class           format A10       heading 'Wait Class'\r\ncolumn Time_Waited          format A8       heading 'Time|Waited|Second'\r\ncolumn instance            format A12       heading 'Inst:|Sid,Serial#'\r\ncolumn sql_id              format A13       heading 'SQL ID'\r\ncolumn Usr               format A11       heading 'Username'\r\n-- column SQL_CHILD_NUMBER  format   9999999       heading 'SQL Child'\r\ncolumn SESSION_STATE     format A9       heading 'Sess Stat'\r\ncolumn wait_events      format A19       heading 'Wait Event'\r\ncolumn Plan_Operation     format A9       heading 'Plan|Operation'\r\ncolumn Plan_Option     format A9       heading 'Plan|Option'\r\ncolumn sql_exec_id      format 99999999       heading 'Sql|Exec_id'\r\nset verify off\r\nSELECT s.INSTANCE_NUMBER||':'||S.SESSION_ID||','||S.SESSION_SERIAL# instance,U.USERNAME Usr,\r\n       TO_CHAR(S.SAMPLE_TIME,'YYYY-MM-DD HH24:MI') sample_time,\r\n       TO_CHAR(S.SQL_EXEC_START,'YYYY-MM-DD HH24:MI') exec_start,\r\n       S.SQL_ID,o.owner||'.'||OBJECT_NAME Obj_name,\r\n       S.IN_HARD_PARSE Hard_Parse,\r\n       --S.SQL_PLAN_OPERATION Plan_Operation,\r\n       S.SQL_PLAN_OPTIONS Plan_Option,\r\n       S.SQL_EXEC_ID sql_exec_id,\r\n     --substr(s.program,instr(s.program,'@')+1, instr(s.program,' ')-instr(s.program,'@')) program\r\n     --substr(S.WAIT_CLASS,1,10) wait_class\r\n     substr(round(S.TIME_WAITED/1000000),1,8) Time_Waited\r\n\t,SESSION_STATE sess_stat \r\n\t,event wait_events\r\n     ,to_char(BLOCKING_INST_ID)||':'||to_char(BLOCKING_SESSION) Block_sess\r\n  FROM\r\n       DBA_HIST_ACTIVE_SESS_HISTORY S,\r\n       DBA_USERS  U\r\n\t   ,dba_objects o\r\n WHERE\r\n       S.USER_ID = U.USER_ID\r\n       AND S.USER_ID != 0\r\n\t   and o.OBJECT_ID=s.CURRENT_OBJ# \r\n  and  s.sample_time >= to_timestamp('&&start_time', 'YYYY-MM-DD HH24:MI')\r\n  and s.sample_time <= to_timestamp('&&end_time', 'YYYY-MM-DD HH24:MI')\r\n   and ((to_char(s.SESSION_ID)='&input') or (upper(S.SQL_PLAN_HASH_VALUE) =upper('&input')) or (upper(U.USERNAME)=upper('&input')) or (upper(S.sql_id) like upper ('&&input%')) or (upper(o.object_name)= upper('&input')))\r\n ORDER BY sample_time,1,4,3;\r\nPROMPT +------------------------------------------------------------------------+\r\nPROMPT +-----------Objects involved during execution of query-------------------+\r\ncol obj_name for a40\r\ncol obj_type for a40\r\ncol owner for a25\r\ncol is_temp_table for a14 heading 'IS_TEMP|Table'\r\nSELECT distinct OWNER owner,OBJECT_NAME obj_name,OBJECT_TYPE obj_type,temporary is_temp_table\r\n   FROM\r\n       DBA_HIST_ACTIVE_SESS_HISTORY S,\r\n       DBA_USERS  U\r\n           ,dba_objects o\r\n WHERE\r\n       S.USER_ID = U.USER_ID\r\n       AND S.USER_ID != 0\r\n           and o.OBJECT_ID=s.CURRENT_OBJ#\r\n  and  s.sample_time >= to_timestamp('&&start_time', 'YYYY-MM-DD HH24:MI')\r\n  and s.sample_time <= to_timestamp('&&end_time', 'YYYY-MM-DD HH24:MI')\r\n   and ((to_char(s.SESSION_ID)='&input') or (upper(S.SQL_PLAN_HASH_VALUE) =upper('&input')) or (upper(U.USERNAME)=upper('&input')) or (upper(S.sql_id) like upper ('&&input%')) or (upper(o.object_name)= upper('&input')))\r\n/
12	Table,Index stats detail	Table,Index details (table_stats)	set markup html on\r\ndefine owner=&1;\r\ndefine table_name=&2;\r\ncol owner NEW_VALUE owner \r\ncol table_name NEW_VALUE table_name \r\n\r\n\r\ncol instance_id heading 'INS'\r\ncol user_id for a10\r\ncol host_id for a10\r\nset markup html on\r\nSET TERMOUT OFF;\r\nCOLUMN current_instance NEW_VALUE current_instance NOPRINT;\r\nCOLUMN db_unique_name NEW_VALUE db_unique_name NOPRINT;\r\nCOLUMN current_timestamp NEW_VALUE current_timestamp  NOPRINT;\r\nSELECT rpad(sys_context('USERENV', 'DB_UNIQUE_NAME'),15)  db_unique_name  FROM DUAL;\r\nSELECT rpad(instance_name, 17) current_instance,rpad(current_timestamp,22) current_timestamp FROM v$instance;\r\nSET TERMOUT ON\r\n\r\nPROMPT\r\nPROMPT +------------------------------------------------------------------------+\r\nPROMPT | Report   : Table stats details(table name  - &table_name)              |\r\nPROMPT | DB_Name  : &db_unique_name                                             |\r\nPROMPT | Timestamp: &current_timestamp                                          |\r\nPROMPT +------------------------------------------------------------------------+\r\n\r\n\r\n\r\nset echo off\r\nset scan on\r\nset lines 160\r\nset pages 66\r\nset verify off\r\nset feedback off\r\nset termout off\r\ncolumn uservar new_value Table_Owner noprint\r\nselect user uservar from dual;\r\nset termout on\r\n\r\nprompt\r\n--accept owner prompt 'Please enter Name of Table Owner: '\r\n--accept table_name  prompt 'Please enter Table Name to show Statistics for: '\r\ncolumn TABLE_NAME heading "Table|Name" format a15\r\ncolumn PARTITION_NAME heading "Partition|Name" format a22\r\ncolumn SUBPARTITION_NAME heading "SubPartition|Name" format a15\r\ncolumn NUM_ROWS heading "Number|of Rows" format 999,999,990\r\ncolumn BLOCKS heading "Blocks" format 9,999,990\r\ncolumn EMPTY_BLOCKS heading "Empty|Blocks" format 999,990\r\ncolumn AVG_SPACE heading "Average|Space" format 9,990\r\ncolumn CHAIN_CNT heading "Chain|Count" format 990\r\ncolumn AVG_ROW_LEN heading "Average|Row Len" format 990\r\ncolumn COLUMN_NAME  heading "Column|Name" format a25\r\ncolumn NULLABLE heading Null|able format a4\r\ncolumn NUM_DISTINCT heading "Distinct|Values" format 999,990,000\r\ncolumn NUM_NULLS heading "Number|Nulls" format 99,990,000\r\ncolumn NUM_BUCKETS heading "Number|Buckets" format 990\r\ncolumn DENSITY heading "Density" format .999990\r\ncolumn INDEX_NAME heading "Index|Name" format a25\r\ncolumn UNIQUENESS heading "Unique" format a9\r\ncolumn BLEV heading "B|Tree|Level" format 90\r\ncolumn LEAF_BLOCKS heading "Leaf|Blks" format 9,990,000\r\ncolumn DISTINCT_KEYS heading "Distinct|Keys" format 999,999,990\r\ncolumn AVG_LEAF_BLOCKS_PER_KEY heading "Average|Leaf Blocks|Per Key" format 99,990\r\ncolumn AVG_DATA_BLOCKS_PER_KEY heading "Average|Data Blocks|Per Key" format 99,990\r\ncolumn CLUSTERING_FACTOR heading "Cluster|Factor" format 9,999,990\r\ncolumn COLUMN_POSITION heading "Col|Pos" format 990\r\ncolumn col heading "Column|Details" format a34\r\ncolumn COLUMN_LENGTH heading "Col|Len" format 990\r\ncolumn GLOBAL_STATS heading "Global|Stats" format a6\r\ncolumn USER_STATS heading "User|Stats" format a6\r\ncolumn SAMPLE_SIZE heading "Sample|Size" format 999,999,990\r\ncolumn to_char(t.last_analyzed,'MM-DD-YYYY') heading "Date|MM-DD-YYYY" format a10\r\nprompt\r\nprompt ***********\r\nprompt Table Level\r\nprompt ***********\r\nprompt\r\nselect \r\n    owner,\r\n    TABLE_NAME,\r\n    NUM_ROWS,\r\n    BLOCKS,\r\n    EMPTY_BLOCKS,\r\n    AVG_SPACE,\r\n    CHAIN_CNT,\r\n    AVG_ROW_LEN,\r\n    GLOBAL_STATS,\r\n    USER_STATS,\r\n    SAMPLE_SIZE,\r\n    to_char(t.last_analyzed,'MM-DD-YYYY')\r\nfrom dba_tables t\r\nwhere \r\n    owner = upper(nvl('&&owner',user))\r\nand table_name = upper('&&table_name')\r\n/\r\nselect\r\n    COLUMN_NAME,\r\n    decode(t.DATA_TYPE,\r\n           'NUMBER',t.DATA_TYPE||'('||\r\n           decode(t.DATA_PRECISION,\r\n                  null,t.DATA_LENGTH||')',\r\n                  t.DATA_PRECISION||','||t.DATA_SCALE||')'),\r\n                  'DATE',t.DATA_TYPE,\r\n                  'LONG',t.DATA_TYPE,\r\n                  'LONG RAW',t.DATA_TYPE,\r\n                  'ROWID',t.DATA_TYPE,\r\n                  'MLSLABEL',t.DATA_TYPE,\r\n                  t.DATA_TYPE||'('||t.DATA_LENGTH||')') ||' '||\r\n    decode(t.nullable,\r\n              'N','NOT NULL',\r\n              'n','NOT NULL',\r\n              NULL) col,\r\n    NUM_DISTINCT,\r\n    DENSITY,\r\n    NUM_BUCKETS,\r\n    NUM_NULLS,\r\n    GLOBAL_STATS,\r\n    USER_STATS,\r\n    SAMPLE_SIZE,\r\n    to_char(t.last_analyzed,'MM-DD-YYYY')\r\nfrom dba_tab_columns t\r\nwhere \r\n    table_name = upper('&&table_name')\r\nand owner = upper(nvl('&&owner',user))\r\n/\r\nselect \r\n    INDEX_NAME,\r\n    UNIQUENESS,\r\n    BLEVEL BLev,\r\n    LEAF_BLOCKS,\r\n    DISTINCT_KEYS,\r\n    NUM_ROWS,\r\n    AVG_LEAF_BLOCKS_PER_KEY,\r\n    AVG_DATA_BLOCKS_PER_KEY,\r\n    CLUSTERING_FACTOR,\r\n    GLOBAL_STATS,\r\n    USER_STATS,\r\n    SAMPLE_SIZE,\r\n    to_char(t.last_analyzed,'MM-DD-YYYY') \r\nfrom \r\n    dba_indexes t\r\nwhere \r\n    table_name = upper('&&table_name')\r\nand table_owner = upper(nvl('&&owner',user))\r\n/\r\nbreak on index_name\r\nselect\r\n    i.INDEX_NAME,\r\n    i.COLUMN_NAME,\r\n    i.COLUMN_POSITION,\r\n    decode(t.DATA_TYPE,\r\n           'NUMBER',t.DATA_TYPE||'('||\r\n           decode(t.DATA_PRECISION,\r\n                  null,t.DATA_LENGTH||')',\r\n                  t.DATA_PRECISION||','||t.DATA_SCALE||')'),\r\n                  'DATE',t.DATA_TYPE,\r\n                  'LONG',t.DATA_TYPE,\r\n                  'LONG RAW',t.DATA_TYPE,\r\n                  'ROWID',t.DATA_TYPE,\r\n                  'MLSLABEL',t.DATA_TYPE,\r\n                  t.DATA_TYPE||'('||t.DATA_LENGTH||')') ||' '||\r\n           decode(t.nullable,\r\n                  'N','NOT NULL',\r\n                  'n','NOT NULL',\r\n                  NULL) col\r\nfrom \r\n    dba_ind_columns i,\r\n    dba_tab_columns t\r\nwhere \r\n    i.table_name = upper('&&table_name')\r\nand owner = upper(nvl('&&Owner',user))\r\nand i.table_name = t.table_name\r\nand i.column_name = t.column_name\r\norder by index_name,column_position\r\n/\r\n\r\nprompt\r\nprompt ***************\r\nprompt Partition Level\r\nprompt ***************\r\n\r\nselect\r\n    PARTITION_NAME,\r\n    NUM_ROWS,\r\n    BLOCKS,\r\n    EMPTY_BLOCKS,\r\n    AVG_SPACE,\r\n    CHAIN_CNT,\r\n    AVG_ROW_LEN,\r\n    GLOBAL_STATS,\r\n    USER_STATS,\r\n    SAMPLE_SIZE,\r\n    to_char(t.last_analyzed,'MM-DD-YYYY')\r\nfrom \r\n    dba_tab_partitions t\r\nwhere \r\n    table_owner = upper(nvl('&&owner',user))\r\nand table_name = upper('&&table_name')\r\norder by partition_position\r\n/\r\n\r\n\r\nbreak on partition_name\r\nselect\r\n    PARTITION_NAME,\r\n    COLUMN_NAME,\r\n    NUM_DISTINCT,\r\n    DENSITY,\r\n    NUM_BUCKETS,\r\n    NUM_NULLS,\r\n    GLOBAL_STATS,\r\n    USER_STATS,\r\n    SAMPLE_SIZE,\r\n    to_char(t.last_analyzed,'MM-DD-YYYY')\r\nfrom \r\n    dba_PART_COL_STATISTICS t\r\nwhere \r\n    table_name = upper('&&table_name')\r\nand owner = upper(nvl('&&owner',user))\r\n/\r\n\r\nbreak on partition_name\r\nselect \r\n    t.INDEX_NAME,\r\n    t.PARTITION_NAME,\r\n    t.BLEVEL BLev,\r\n    t.LEAF_BLOCKS,\r\n    t.DISTINCT_KEYS,\r\n    t.NUM_ROWS,\r\n    t.AVG_LEAF_BLOCKS_PER_KEY,\r\n    t.AVG_DATA_BLOCKS_PER_KEY,\r\n    t.CLUSTERING_FACTOR,\r\n    t.GLOBAL_STATS,\r\n    t.USER_STATS,\r\n    t.SAMPLE_SIZE,\r\n    to_char(t.last_analyzed,'MM-DD-YYYY')\r\nfrom \r\n    dba_ind_partitions t, \r\n    dba_indexes i\r\nwhere \r\n    i.table_name = upper('&&table_name')\r\nand i.table_owner = upper(nvl('&&owner',user))\r\nand i.owner = t.index_owner\r\nand i.index_name=t.index_name\r\n/\r\n\r\n\r\nprompt\r\nprompt ***************\r\nprompt SubPartition Level\r\nprompt ***************\r\n\r\nselect \r\n    PARTITION_NAME,\r\n    SUBPARTITION_NAME,\r\n    NUM_ROWS,\r\n    BLOCKS,\r\n    EMPTY_BLOCKS,\r\n    AVG_SPACE,\r\n    CHAIN_CNT,\r\n    AVG_ROW_LEN,\r\n    GLOBAL_STATS,\r\n    USER_STATS,\r\n    SAMPLE_SIZE,\r\n    to_char(t.last_analyzed,'MM-DD-YYYY')\r\nfrom \r\n    dba_tab_subpartitions t\r\nwhere \r\n    table_owner = upper(nvl('&&owner',user))\r\nand table_name = upper('&&table_name')\r\norder by SUBPARTITION_POSITION\r\n/\r\nbreak on partition_name\r\nselect \r\n    p.PARTITION_NAME,\r\n    t.SUBPARTITION_NAME,\r\n    t.COLUMN_NAME,\r\n    t.NUM_DISTINCT,\r\n    t.DENSITY,\r\n    t.NUM_BUCKETS,\r\n    t.NUM_NULLS,\r\n    t.GLOBAL_STATS,\r\n    t.USER_STATS,\r\n    t.SAMPLE_SIZE,\r\n    to_char(t.last_analyzed,'MM-DD-YYYY')\r\nfrom \r\n    dba_SUBPART_COL_STATISTICS t, \r\n    dba_tab_subpartitions p\r\nwhere \r\n    t.table_name = upper('&&table_name')\r\nand t.owner = upper(nvl('&&owner',user))\r\nand t.subpartition_name = p.subpartition_name\r\nand t.owner = p.table_owner\r\nand t.table_name=p.table_name\r\n/\r\n\r\nbreak on partition_name\r\nselect \r\n    t.INDEX_NAME,\r\n    t.PARTITION_NAME,\r\n    t.SUBPARTITION_NAME,\r\n    t.BLEVEL BLev,\r\n    t.LEAF_BLOCKS,\r\n    t.DISTINCT_KEYS,\r\n    t.NUM_ROWS,\r\n    t.AVG_LEAF_BLOCKS_PER_KEY,\r\n    t.AVG_DATA_BLOCKS_PER_KEY,\r\n    t.CLUSTERING_FACTOR,\r\n    t.GLOBAL_STATS,\r\n    t.USER_STATS,\r\n    t.SAMPLE_SIZE,\r\n    to_char(t.last_analyzed,'MM-DD-YYYY')\r\nfrom \r\n    dba_ind_subpartitions t, \r\n    dba_indexes i\r\nwhere \r\n    i.table_name = upper('&&table_name')\r\nand i.table_owner = upper(nvl('&&owner',user))\r\nand i.owner = t.index_owner\r\nand i.index_name=t.index_name\r\n/\r\n\r\nclear breaks\r\nset echo on
28	Temp Tablespace space	Temp Tablespace space (sortspace)	SET TERMOUT OFF;\r\nCOLUMN current_instance NEW_VALUE current_instance NOPRINT;\r\nCOLUMN db_unique_name NEW_VALUE db_unique_name NOPRINT;\r\nCOLUMN current_timestamp NEW_VALUE current_timestamp  NOPRINT;\r\nSELECT rpad(sys_context('USERENV', 'DB_UNIQUE_NAME'),15)  db_unique_name  FROM DUAL;\r\nSELECT rpad(instance_name, 17) current_instance,rpad(to_char(current_timestamp,'DD-MON-YY HH24:MI'),17) current_timestamp FROM v$instance;\r\nSET TERMOUT ON\r\n\r\nPROMPT\r\nPROMPT +------------------------------------------------------------------------+\r\nPROMPT   Report   : TEMP space utilization detail\r\nPROMPT   DB_Name  : &db_unique_name\r\nPROMPT   Timestamp: &current_timestamp\r\nPROMPT +------------------------------------------------------------------------+\r\n\r\n\r\nprompt\r\nprompt\r\nset linesize 200\r\nset pagesize 100\r\ncol total_mb format 999,999.9\r\ncol used_mb  format 999,999.9\r\ncol free_mb  format 999,999.9\r\ncol free_prcnt format 999.9 heading '%free'\r\ncol inst_id  format 99\r\n\r\nprompt +------------------------+\r\nprompt  TOTAL Temp Space Usage...\r\nprompt +------------------------+\r\nselect vs.inst_id,vs.TABLESPACE_NAME\r\n      ,t3.maxsize total_mb\r\n      ,vs.USED_BLOCKS*t2.block_size_kb/1024 used_mb\r\n      ,(t3.maxsize-(vs.USED_BLOCKS*t2.block_size_kb/1024)) free_mb\r\n\t,round(100*(t3.maxsize-(vs.USED_BLOCKS*t2.block_size_kb/1024))/t3.maxsize,2) free_prcnt\r\n  from gv$sort_segment vs\r\n     , (select value/1024 block_size_kb from v$parameter where name = 'db_block_size') t2\r\n     , (select d.tablespace_name, sum(bytes/1024/1024) maxsize\r\n          from dba_temp_files d\r\n         group by d.tablespace_name) t3\r\n  where vs.tablespace_name = t3.tablespace_name\r\n        order by 1,2;\r\n--\r\n--      Sort Space Usage by Session\r\n--\r\nprompt +----------------------------+\r\nprompt  Sort space usage by session\r\nprompt +----------------------------+\r\nset linesize 200\r\nset pagesize 200\r\ncol SID_SERIAL for a13 heading "SID,SERIAL#"\r\ncol spid for a6\r\ncol inst_id for 999 heading "Inst|ID"\r\ncol username for a15\r\ncol OSUSER for a9\r\ncol module for a20\r\ncol program for a20\r\ncol tablespace for a15\r\nSELECT   S.inst_id,S.sid || ',' || S.serial# sid_serial, S.username, S.osuser, P.spid, S.module,\r\n         S.program, SUM (T.blocks) * TBS.block_size / 1024 / 1024 mb_used, T.tablespace,\r\n         COUNT(*) sort_ops\r\nFROM     gv$sort_usage T, gv$session S, dba_tablespaces TBS, gv$process P\r\nWHERE    T.session_addr = S.saddr\r\nAND      S.paddr = P.addr\r\nAND      T.tablespace = TBS.tablespace_name\r\nAND      S.inst_id=t.inst_id\r\nAND      p.inst_id=s.inst_id\r\nGROUP BY s.inst_id,S.sid, S.serial#, S.username, S.osuser, P.spid, S.module,\r\n         S.program, TBS.block_size, T.tablespace\r\nORDER BY s.inst_id,S.sid,S.serial#;\r\n--\r\n--      Sort Space Usage by Statement\r\n--\r\nprompt +-------------------------------+\r\nprompt  Sort space usage by statement\r\nprompt +-------------------------------+\r\ncol sql_text for a65\r\nSELECT   t.inst_id,S.sid || ',' || S.serial# sid_serial, S.username,\r\n         T.blocks * TBS.block_size / 1024 / 1024 mb_used, T.tablespace,\r\n         Q.sql_id sql_id, Q.hash_value, Q.sql_text\r\nFROM     gv$sort_usage T, gv$session S,gv$sqlarea Q, dba_tablespaces TBS\r\nWHERE  t.inst_id=s.inst_id and s.inst_id=q.inst_id  \r\nAND    S.sql_id=Q.sql_id\r\nAND    S.sql_id=T.sql_id\r\nAND \tT.session_addr = S.saddr\r\nAND      T.sqladdr = Q.address (+)\r\nAND      T.tablespace = TBS.tablespace_name\r\nORDER BY S.sid;
38	RMAN Backup	RMAN Backup (rman_details)	SET TERMOUT OFF;\r\nCOLUMN current_instance NEW_VALUE current_instance NOPRINT;\r\nCOLUMN db_unique_name NEW_VALUE db_unique_name NOPRINT;\r\nCOLUMN current_timestamp NEW_VALUE current_timestamp  NOPRINT;\r\nSELECT rpad(sys_context('USERENV', 'DB_UNIQUE_NAME'),15)  db_unique_name  FROM DUAL;\r\nSELECT rpad(instance_name, 17) current_instance,rpad(to_char(current_timestamp,'DD-MON-YY HH24:MI'),17) current_timestamp FROM v$instance;\r\nSET TERMOUT ON\r\n\r\nPROMPT\r\nPROMPT +------------------------------------+\r\nPROMPT   Report   : RMAN DB Backup Details \r\nPROMPT   DB_Name  : &db_unique_name\r\nPROMPT   Timestamp: &current_timestamp\r\nPROMPT +------------------------------------+\r\n\r\n--LAST 10 DAYS JOBS\r\nset linesize 200\r\nset pagesize 200\r\nCOL in_size  FORMAT a10\r\nCOL out_size FORMAT a10\r\ncol STATUS for a20\r\ncol COMMAND_ID for a20\r\nselect SESSION_STAMP,SESSION_KEY,INPUT_TYPE, COMMAND_ID,to_char(START_TIME,'dd-mon-yyyy hh24:mi:ss') start_time,\r\nINPUT_BYTES_DISPLAY in_size,OUTPUT_BYTES_DISPLAY out_size, \r\nto_char(END_TIME,'dd-mon-yyyy hh24:mi:ss') end_time,STATUS, round(ELAPSED_SECONDS/60) Minutes \r\nfrom V$RMAN_BACKUP_JOB_DETAILS where START_TIME > sysdate-10 order by to_date(START_TIME,'dd-mon-yyyy hh24:mi:ss');\r\n\r\n\r\nPROMPT +------------------------------------+\r\nPROMPT   RMAN Execution Command History\r\nPROMPT +------------------------------------+\r\ncol OPERATION for a11\r\ncol output for a80\r\nset linesize 140\r\nset pagesize 500\r\ncol status for a12\r\ncol sid for 9999\r\ncol START_TIME for a16\r\nselect\r\na.sid,\r\na.recid,\r\nto_char(b.start_time,'dd-mm-yy hh24:mi') "START_TIME",\r\nb.operation,\r\nb.status,\r\na.output\r\nfrom v$rman_output a,\r\nv$rman_status b\r\nwhere a.rman_status_recid = b.recid\r\nand a.rman_status_stamp = b.stamp\r\norder by a.recid\r\n/
37	ASM Disk Performance	ASM Disk Performance (asm_disks_perf)	-- |----------------------------------------------------------------------------|\r\n-- | DATABASE : Oracle                                                          |\r\n-- | FILE     : asm_disks_perf.sql                                              |\r\n-- | CLASS    : Automatic Storage Management                                    |\r\n-- | PURPOSE  : Provide a summary report of all disks contained within all ASM  |\r\n-- |           disk groups along with their performance metrics.                |\r\n-- | NOTE     : As with any code, ensure to test this script in a development   |\r\n-- |            environment before attempting to run it in production.          |\r\n-- +----------------------------------------------------------------------------+\r\n\r\nSET TERMOUT OFF;\r\nCOLUMN current_instance NEW_VALUE current_instance NOPRINT;\r\nSELECT rpad(sys_context('USERENV', 'INSTANCE_NAME'), 17) current_instance FROM dual;\r\nSET TERMOUT ON;\r\n\r\nPROMPT \r\nPROMPT +------------------------------------------------------------------------+\r\nPROMPT | Report   : ASM Disk Performance                                        |\r\nPROMPT | Instance : &current_instance                                           |\r\nPROMPT +------------------------------------------------------------------------+\r\n\r\nSET ECHO        OFF\r\nSET FEEDBACK    6\r\nSET HEADING     ON\r\nSET LINESIZE    256\r\nSET PAGESIZE    50000\r\nSET TERMOUT     ON\r\nSET TIMING      OFF\r\nSET TRIMOUT     ON\r\nSET TRIMSPOOL   ON\r\nSET VERIFY      OFF\r\n\r\nCLEAR COLUMNS\r\nCLEAR BREAKS\r\nCLEAR COMPUTES\r\n\r\nCOLUMN disk_group_name    FORMAT a22                    HEAD 'Disk Group Name'\r\nCOLUMN disk_path          FORMAT a27                    HEAD 'Disk Path'\r\nCOLUMN reads              FORMAT 999,999,999        HEAD 'Reads'\r\nCOLUMN writes             FORMAT 999,999,999        HEAD 'Writes'\r\nCOLUMN read_errs          FORMAT 999            HEAD 'Read|Errors'\r\nCOLUMN write_errs         FORMAT 999            HEAD 'Write|Errors'\r\nCOLUMN read_time          FORMAT 999,999,999        HEAD 'Read|Time'\r\nCOLUMN write_time         FORMAT 999,999,999        HEAD 'Write|Time'\r\nCOLUMN bytes_read         FORMAT 999,999,999,999,999    HEAD 'Bytes|Read'\r\nCOLUMN bytes_written      FORMAT 999,999,999,999,999    HEAD 'Bytes|Written'\r\n\r\nBREAK ON report ON disk_group_name SKIP 2\r\n\r\nCOMPUTE sum LABEL ""              OF reads writes read_errs write_errs read_time write_time bytes_read bytes_written ON disk_group_name\r\nCOMPUTE sum LABEL "Grand Total: " OF reads writes read_errs write_errs read_time write_time bytes_read bytes_written ON report\r\n\r\nSELECT\r\n    a.name                disk_group_name\r\n  , b.path                disk_path\r\n  , b.reads               reads\r\n  , b.writes              writes\r\n  , b.read_errs           read_errs \r\n  , b.write_errs          write_errs\r\n  , b.read_time           read_time\r\n  , b.write_time          write_time\r\n  , b.bytes_read          bytes_read\r\n  , b.bytes_written       bytes_written\r\nFROM\r\n    v$asm_diskgroup a JOIN v$asm_disk b USING (group_number)\r\nORDER BY\r\n    a.name,b.path\r\n/
24	ADDM report(Between date)	ADDM report(Between date) (qry_addm_all)	SET TERMOUT OFF;\r\nCOLUMN current_instance NEW_VALUE current_instance NOPRINT;\r\nCOLUMN db_unique_name NEW_VALUE db_unique_name NOPRINT;\r\nCOLUMN current_timestamp NEW_VALUE current_timestamp  NOPRINT;\r\nSELECT rpad(sys_context('USERENV', 'DB_UNIQUE_NAME'),15)  db_unique_name  FROM DUAL;\r\nSELECT rpad(instance_name, 17) current_instance,rpad(current_timestamp,22) current_timestamp FROM v$instance;\r\nSET TERMOUT ON\r\nset verify off\r\ndefine start_time="&1"\r\ndefine end_time="&2"\r\n\r\nPROMPT\r\nPROMPT +--------------------------------------------------------------------------------------+\r\nPROMPT   Report   : ADDM Diagnostic Report as on &current_timestamp\r\nPROMPT   Duration : Between &start_time and &end_time \r\nPROMPT   DB_Name  : &db_unique_name\r\nPROMPT   Timestamp: &current_timestamp\r\nPROMPT +--------------------------------------------------------------------------------------+\r\n\r\n\r\n\r\nset linesize 200\r\nset verify off\r\nSelect distinct to_char(a.execution_end,'DD-MON-YY HH24:MI') execution_end, b.type, d.rank, d.type,\r\n'Message           : '||b.message MESSAGE,\r\n'Command To correct: '||c.command COMMAND,\r\n'Action Message    : '||c.message ACTION_MESSAGE\r\nFrom dba_advisor_tasks a, dba_advisor_findings b,\r\nDba_advisor_actions c, dba_advisor_recommendations d\r\nWhere a.owner=b.owner and a.task_id=b.task_id\r\nAnd b.task_id=d.task_id and b.finding_id=d.finding_id\r\nAnd a.task_id=c.task_id and d.rec_id=c.rec_Id\r\nAnd a.task_name like 'ADDM%' and a.status='COMPLETED'\r\nAnd a.EXECUTION_START >= to_timestamp('&start_time', 'YYYY-MM-DD HH24:MI')\r\nAnd a.EXECUTION_END <= to_timestamp('&end_time', 'YYYY-MM-DD HH24:MI') \r\n--And c.message like '%sqlid%'\r\nOrder by execution_end,d.rank\r\n/
25	Archive Gap	Archive Gap (arch_log_hist_qry)	SET TERMOUT OFF;\r\nCOLUMN current_instance NEW_VALUE current_instance NOPRINT;\r\nCOLUMN db_unique_name NEW_VALUE db_unique_name NOPRINT;\r\nCOLUMN current_timestamp NEW_VALUE current_timestamp  NOPRINT;\r\nSELECT rpad(sys_context('USERENV', 'DB_UNIQUE_NAME'),15)  db_unique_name  FROM DUAL;\r\nSELECT rpad(instance_name, 17) current_instance,rpad(current_timestamp,22) current_timestamp FROM v$instance;\r\nSET TERMOUT ON\r\n\r\nPROMPT\r\nPROMPT +------------------------------------------------------------------------+\r\nPROMPT | Report   : Arch Log Gap Report                                         |\r\nPROMPT | DB_Name  : &db_unique_name                                             |\r\nPROMPT | Timestamp: &current_timestamp                                        |\r\nPROMPT +------------------------------------------------------------------------+\r\n\r\nSET ECHO        OFF\r\nSET FEEDBACK    6\r\nSET HEADING     ON\r\nSET LINESIZE    256\r\nSET PAGESIZE    50000\r\nSET TERMOUT     ON\r\nSET TIMING      OFF\r\nSET TRIMOUT     ON\r\nSET TRIMSPOOL   ON\r\nSET VERIFY      OFF\r\n\r\nPROMPT\r\nPROMPT +-------------------+\r\nPROMPT   CHECK ARCHIVE GAP \r\nPROMPT +-------------------+\r\nPROMPT\r\ncol "Last Sequence Received" heading ' Last Sequence| Received'\r\ncol "Last Sequence Applied" heading ' Last Sequence| Applied'\r\nSELECT A.TRD_ARCHIVED, A.LOG_ARCHIVED, B.LOG_APPLIED, B.APPLIED_TIME, A.LOG_ARCHIVED - B.LOG_APPLIED AS LOG_GAP\r\nFROM\r\n(SELECT THREAD# TRD_ARCHIVED, MAX(SEQUENCE#) LOG_ARCHIVED\r\nFROM V$ARCHIVED_LOG WHERE ARCHIVED='YES' GROUP BY THREAD#) A,\r\n(SELECT THREAD# TRD_APPLIED, MAX(SEQUENCE#) LOG_APPLIED, TO_CHAR(MAX(COMPLETION_TIME),'MON-DD-YYYY HH24:MI:SS') APPLIED_TIME\r\nFROM V$ARCHIVED_LOG WHERE APPLIED='YES' GROUP BY THREAD#) B\r\nWHERE A.TRD_ARCHIVED=B.TRD_APPLIED\r\nORDER BY 1;\r\n\r\nalter session set nls_date_format ='DD-MON-YY HH24:MI:SS';\r\nPROMPT\r\nPROMPT +----------------------------------------------------+\r\nPROMPT   TOTAL NUMBER OF ARCHIVE LOGS GENERATED(EACH HOUR)\r\nPROMPT +----------------------------------------------------+\r\nPROMPT\r\n\r\ncol MidN format 9999\r\ncol 1AM format 9999\r\ncol 2AM format 9999\r\ncol 3AM format 9999\r\ncol 4AM format 9999\r\ncol 5AM format 9999\r\ncol 6AM format 9999\r\ncol 7AM format 99999\r\ncol 8AM format 99999\r\ncol 9AM format 9999\r\ncol 10AM format 9999\r\ncol 11AM format 9999\r\ncol Noon format 9999\r\ncol 1PM format 9999\r\ncol 2PM format 9999\r\ncol 3PM format 9999\r\ncol 4PM format 9999\r\ncol 5PM format 9999\r\ncol 6PM format 9999\r\ncol 7PM format 9999\r\ncol 8PM format 9999\r\ncol 9PM format 9999\r\ncol 10PM format 9999\r\ncol 11PM format 9999\r\nselect to_char(first_time,'mm/dd/yy') logdate,\r\nsum(decode(to_char(first_time,'hh24'),'00',1,0)) "MidN",\r\nsum(decode(to_char(first_time,'hh24'),'01',1,0)) "1AM",\r\nsum(decode(to_char(first_time,'hh24'),'02',1,0)) "2AM",\r\nsum(decode(to_char(first_time,'hh24'),'03',1,0)) "3AM",\r\nsum(decode(to_char(first_time,'hh24'),'04',1,0)) "4AM",\r\nsum(decode(to_char(first_time,'hh24'),'05',1,0)) "5AM",\r\nsum(decode(to_char(first_time,'hh24'),'06',1,0)) "6AM",\r\nsum(decode(to_char(first_time,'hh24'),'07',1,0)) "7AM",\r\nsum(decode(to_char(first_time,'hh24'),'08',1,0)) "8AM",\r\nsum(decode(to_char(first_time,'hh24'),'09',1,0)) "9AM",\r\nsum(decode(to_char(first_time,'hh24'),'10',1,0)) "10AM",\r\nsum(decode(to_char(first_time,'hh24'),'11',1,0)) "11AM",\r\nsum(decode(to_char(first_time,'hh24'),'12',1,0)) "Noon",\r\nsum(decode(to_char(first_time,'hh24'),'13',1,0)) "1PM",\r\nsum(decode(to_char(first_time,'hh24'),'14',1,0)) "2PM",\r\nsum(decode(to_char(first_time,'hh24'),'15',1,0)) "3PM",\r\nsum(decode(to_char(first_time,'hh24'),'16',1,0)) "4PM",\r\nsum(decode(to_char(first_time,'hh24'),'17',1,0)) "5PM",\r\nsum(decode(to_char(first_time,'hh24'),'18',1,0)) "6PM",\r\nsum(decode(to_char(first_time,'hh24'),'19',1,0)) "7PM",\r\nsum(decode(to_char(first_time,'hh24'),'20',1,0)) "8PM",\r\nsum(decode(to_char(first_time,'hh24'),'21',1,0)) "9PM",\r\nsum(decode(to_char(first_time,'hh24'),'22',1,0)) "10PM",\r\nsum(decode(to_char(first_time,'hh24'),'23',1,0)) "11PM"\r\nfrom v$log_history\r\nwhere first_time > sysdate-8\r\ngroup by to_char(first_time,'mm/dd/yy')\r\norder by 1;\r\n\r\n\r\nPROMPT\r\nPROMPT +-----------------------------------------------+\r\nPROMPT   CHECK IF ANY DATAGUARD RELATED ERROR GENERATED\r\nPROMPT +-----------------------------------------------+\r\nPROMPT\r\n-- Determine if any error conditions have been reached by querying the v$dataguard_status\r\n-- view (view only available in 9.2.0 and above):\r\ncolumn message format a80\r\nselect message, timestamp\r\nfrom v$dataguard_status\r\nwhere severity in ('Error','Fatal')\r\norder by timestamp;\r\n\r\nPROMPT\r\nPROMPT +------------------------------+\r\nPROMPT   FLASH RECOVERY AREA STATUS\r\nPROMPT +------------------------------+\r\nPROMPT\r\nselect * from v$flash_recovery_area_usage;\r\n\r\n--col name for a40\r\n--SELECT NAME,\r\n---ROUND(SPACE_LIMIT / 1048576) SPACE_LIMIT_MB,\r\n--ROUND(SPACE_USED / 1048576) SPACE_USED_MB,\r\n--ROUND(((SPACE_USED / 1048576) * 100) / (SPACE_LIMIT / 1048576), 2) PRC_USED\r\n--FROM VRECOVERY_FILE_DEST; \r\n\r\nselect distinct INST_ID,PROCESS, CLIENT_PROCESS,SEQUENCE#,THREAD#,STATUS from gv$managed_standby order by 1,2,3,4;\r\n\r\ncol Name for a40\r\nSELECT distinct a.NAME, ROUND(a.SPACE_LIMIT/1024/1024/1024,2) SPACE_LIMIT_GB,\r\nROUND((a.SPACE_LIMIT - a.SPACE_USED + a.SPACE_RECLAIMABLE)/1024/1024/1024,2) SPACE_AVAILABLE_GB,\r\nROUND((a.SPACE_USED - a.SPACE_RECLAIMABLE)/a.SPACE_LIMIT*100,2) PERCENT_FULL,\r\nround(b.TOTAL_MB/1000) DG_SPACE_TOTAL_GB, round(b.FREE_MB/1000)  DG_SPACE_FREE_GB\r\nFROM V$RECOVERY_FILE_DEST a, gV$ASM_DISKGROUP b\r\nwhere b.name=substr(a.name,2);\r\n\r\n\r\nPROMPT\r\nPROMPT +-------------------------+\r\nPROMPT   OUTSTANDING ALERT(IF ANY)\r\nPROMPT +-------------------------+\r\nPROMPT\r\nPROMPT Note:warning alert when reclaimable space is less than 15% and a critical alert when reclaimable space is less than 3%\r\nPROMPT\r\nset linesize 200\r\nset pagesize 200\t\r\ncol INSTANCE_NAME for a6 heading 'Inst|Name'\r\ncol MESSAGE_LEVEL for 999 heading 'Mess|lvl'\r\ncol OBJECT_TYPE for a14\r\ncol REASON for a80\r\ncol SUGGESTED_ACTION for a40\r\n select \r\n  to_char(creation_time, 'dd-mm-yyyy hh24:mi') crt,\r\n  instance_name,         \r\n  object_type,           \r\n  message_type,        \r\n  message_level,      \r\n  reason,            \r\n  suggested_action \r\nfrom\r\n  dba_outstanding_alerts\r\n order by\r\n     creation_time;
26	Alert log contents	Alert log contents (alert_qry)	set linesize 200\r\ncol MESSAGE_TEXT for a120\r\ncol alert_time  format a20\r\nset pagesize 100\r\n\r\ncol instance_id heading 'INS'\r\ncol user_id for a10\r\ncol host_id for a10\r\nset markup html on\r\nSET TERMOUT OFF;\r\nCOLUMN current_instance NEW_VALUE current_instance NOPRINT;\r\nCOLUMN db_unique_name NEW_VALUE db_unique_name NOPRINT;\r\nCOLUMN current_timestamp NEW_VALUE current_timestamp  NOPRINT;\r\nSELECT rpad(sys_context('USERENV', 'DB_UNIQUE_NAME'),15)  db_unique_name  FROM DUAL;\r\nSELECT rpad(instance_name, 17) current_instance,rpad(current_timestamp,22) current_timestamp FROM v$instance;\r\nSET TERMOUT ON\r\n\r\nPROMPT\r\nPROMPT +------------------------------------------------------------------------+\r\nPROMPT | Report   : Alert Log Query (ORA-%) {latest 2 Days Only}                |\r\nPROMPT | DB_Name  : &db_unique_name                                             |\r\nPROMPT | Timestamp: &current_timestamp                                          |\r\nPROMPT +------------------------------------------------------------------------+\r\n\r\n\r\nselect distinct MESSAGE_TEXT,to_char(ORIGINATING_TIMESTAMP,'DD-MON-YY HH24:MI') alert_time, instance_id, user_id,host_id from V$DIAG_ALERT_EXT where \r\nMESSAGE_TEXT like 'ORA-%' and  \r\nORIGINATING_TIMESTAMP  > systimestamp - interval '2' day\r\norder by alert_time desc\r\n/
17	Session Hist Top IO Query	Sess Hist Top IO Query (show_sess_usr_hist_top_io)	SET TERMOUT OFF;\r\nCOLUMN current_instance NEW_VALUE current_instance NOPRINT;\r\nCOLUMN db_unique_name NEW_VALUE db_unique_name NOPRINT;\r\nCOLUMN current_timestamp NEW_VALUE current_timestamp  NOPRINT;\r\nSELECT rpad(sys_context('USERENV', 'DB_UNIQUE_NAME'),15)  db_unique_name  FROM DUAL;\r\nSELECT rpad(instance_name, 17) current_instance,rpad(to_char(current_timestamp,'DD-MON-YY HH24:MI'),17) current_timestamp FROM v$instance;\r\nSET TERMOUT ON\r\n\r\nset linesize 160\r\nset pagesize 40\r\n--clear columns\r\n--clear breaks\r\ndefine start_time='&1'\r\ndefine end_time='&2'\r\nttitle off\r\n\r\n\r\nPROMPT\r\nPROMPT +--------------------------------------------------------------------------------------+\r\nPROMPT   Report   : Session History  of Top 10 IO Query\r\nPROMPT   Duration : Between &start_time and &end_time \r\nPROMPT   DB_Name  : &db_unique_name\r\nPROMPT   Timestamp: &current_timestamp\r\nPROMPT +--------------------------------------------------------------------------------------+\r\n\r\n\r\n\r\ncolumn usr                 format a11       Heading 'User'\r\ncolumn INSTANCE_NUMBER     format 9      heading 'I|N|S'\r\ncolumn SESSION_ID          format 9999      heading 'S|I|D'\r\ncolumn SQL_PLAN_HASH_VALUE format A10       heading 'SQL PLAN|HASH_VALUE'\r\ncolumn stat                format A1        heading 'S|t|a|t'\r\ncolumn serial              format 9999999   heading 'Serial#'\r\ncolumn machine             format A24       heading 'Machine'\r\ncolumn program             format A16       heading 'Program'\r\ncolumn physical_reads      format 999999999 heading 'Physical|Reads'\r\ncolumn chgs                format A9        heading 'Logical|  Chgs'\r\ncolumn Block_sess          format A6 heading 'Blk|sess'\r\ncolumn module              format A16       heading 'Module'\r\ncolumn Obj_name            format A16       heading 'Obj|Name'\r\ncolumn wait_class           format A10       heading 'Wait Class'\r\ncolumn Time_Waited          format A10       heading 'Time|Waited'\r\ncolumn instance            format A13       heading 'Inst:|Sid,Serial#'\r\ncolumn sql_id              format A13       heading 'SQL ID'\r\nset verify off\r\ncol type for a15\r\ncol "CPU" for 999999.9\r\ncol "IO" for 999999.9\r\nselect * from (\r\nselect\r\n     ash.SQL_ID , ash.SQL_PLAN_HASH_VALUE Plan_hash, aud.name type,\r\n     sum(decode(ash.session_state,'ON CPU',1,0))     "CPU",\r\n     sum(decode(ash.session_state,'WAITING',1,0))    -\r\n     sum(decode(ash.session_state,'WAITING', decode(wait_class, 'User I/O',1,0),0))    "WAIT" ,\r\n     sum(decode(ash.session_state,'WAITING', decode(wait_class, 'User I/O',1,0),0))    "IO" ,\r\n     sum(decode(ash.session_state,'ON CPU',1,1))     "TOTAL"\r\nfrom dba_hist_active_sess_history ash,\r\n     audit_actions aud\r\nwhere SQL_ID is not NULL\r\n     and ash.sql_opcode=aud.action\r\n    and ash.sample_time >= to_timestamp('&start_time', 'YYYY-MM-DD HH24:MI')\r\n    and ash.sample_time <= to_timestamp('&end_time', 'YYYY-MM-DD HH24:MI') \r\ngroup by sql_id, SQL_PLAN_HASH_VALUE   , aud.name \r\norder by sum(decode(session_state,'ON CPU',1,1))   desc\r\n) where  rownum <= 10\r\n/
21	Session History(All sessions)	Session History(All sessions)	REM   Show session history of all sessions includes  blocked/non blocked  or wait/non-wait event \r\nSET TERMOUT OFF;\r\nCOLUMN current_instance NEW_VALUE current_instance NOPRINT;\r\nCOLUMN db_unique_name NEW_VALUE db_unique_name NOPRINT;\r\nCOLUMN current_timestamp NEW_VALUE current_timestamp  NOPRINT;\r\nSELECT rpad(sys_context('USERENV', 'DB_UNIQUE_NAME'),15)  db_unique_name  FROM DUAL;\r\nSELECT rpad(instance_name, 17) current_instance,rpad(to_char(current_timestamp,'DD-MON-YY HH24:MI'),17) current_timestamp FROM v$instance;\r\nSET TERMOUT ON\r\n\r\nPROMPT\r\nPROMPT +--------------------------------------------------------------------------------------+\r\nPROMPT   Report   : Session History Details(All Sessions)\r\nPROMPT   Duration : Between &2 and &3 \r\nPROMPT   DB_Name  : &db_unique_name\r\nPROMPT   Timestamp: &current_timestamp\r\nPROMPT +--------------------------------------------------------------------------------------+\r\n\r\n\r\nset linesize 180\r\nset pagesize 40\r\n--clear columns\r\n--clear breaks\r\ndefine input=&1\r\ndefine start_time=&2\r\ndefine end_time=&3\r\nttitle off\r\n\r\ncolumn usr                 format a11       Heading 'User'\r\ncolumn INSTANCE_NUMBER     format 9      heading 'I|N|S'\r\ncolumn SESSION_ID          format 9999      heading 'S|I|D'\r\ncolumn SQL_PLAN_HASH_VALUE format A10       heading 'SQL PLAN|HASH_VALUE'\r\ncolumn stat                format A1        heading 'S|t|a|t'\r\ncolumn serial              format 9999999   heading 'Serial#'\r\ncolumn machine             format A18       heading 'Machine'\r\ncolumn program             format A16       heading 'Program'\r\ncolumn physical_reads      format 999999999 heading 'Physical|Reads'\r\ncolumn chgs                format A9        heading 'Logical|  Chgs'\r\ncolumn Block_sess          format A6 heading 'Blk|sess'\r\ncolumn module              format A16       heading 'Module'\r\ncolumn Obj_name            format A24       heading 'Obj|Name'\r\ncolumn wait_class           format A10       heading 'Wait Class'\r\ncolumn Time_Waited          format A8       heading 'Time|Waited|Second'\r\ncolumn instance            format A12       heading 'Inst:|Sid,Serial#'\r\ncolumn sql_id              format A13       heading 'SQL ID'\r\n-- column SQL_CHILD_NUMBER  format   9999999       heading 'SQL Child'\r\ncolumn SESSION_STATE     format A9       heading 'Sess Stat'\r\ncolumn wait_events      format A19       heading 'Sess Event'\r\nset verify off\r\nSELECT s.INSTANCE_NUMBER||':'||S.SESSION_ID||','||S.SESSION_SERIAL# instance,U.USERNAME Usr,\r\n       TO_CHAR(S.SAMPLE_TIME,'YYYY-MM-DD HH24:MI') sample_time,\r\n       to_char(s.SQL_PLAN_HASH_VALUE) SQL_PLAN_HASH_VALUE,S.SQL_ID,o.owner||'.'||OBJECT_NAME Obj_name,\r\n substr(s.program,instr(s.program,'@')+1,\r\n              instr(s.program,' ')-instr(s.program,'@')) machine\r\n     ,substr(S.WAIT_CLASS,1,10) wait_class\r\n     ,substr(round(S.TIME_WAITED/1000000),1,10) Time_Waited\r\n\t,SESSION_STATE \r\n\t,event wait_events\r\n     ,to_char(BLOCKING_INST_ID)||':'||to_char(BLOCKING_SESSION) Block_sess\r\n  FROM\r\n       DBA_HIST_ACTIVE_SESS_HISTORY S,\r\n       DBA_USERS  U\r\n\t   ,dba_objects o\r\n WHERE\r\n       S.USER_ID = U.USER_ID\r\n       AND S.USER_ID != 0\r\n\t   and o.OBJECT_ID=s.CURRENT_OBJ# \r\n    and  s.sample_time >= to_timestamp('&&start_time', 'YYYY-MM-DD HH24:MI')\r\n    and s.sample_time <= to_timestamp('&&end_time', 'YYYY-MM-DD HH24:MI')\r\n --  and (s.blocking_session is not null or s.wait_class is not null)\r\n  and round(S.TIME_WAITED/1000000) > 0\r\n   and ((to_char(s.SESSION_ID)='&input') or (upper(S.SQL_PLAN_HASH_VALUE) =upper('&input')) or (upper(U.USERNAME)=upper('&input')) or (upper(S.sql_id) like upper ('&&input%')) or (upper(o.object_name) = upper('&input')))\r\n ORDER BY sample_time,1,4,3;\r\nPROMPT +-------------------------------------------------------------------------+\r\nPROMPT +-----------Objects involved during execution of query-------------------+\r\ncol obj_name for a40\r\ncol obj_type for a40\r\ncol owner for a25\r\ncol is_temp_table for a14 heading 'IS_TEMP|Table'\r\nSELECT distinct OWNER owner,OBJECT_NAME obj_name,OBJECT_TYPE obj_type,temporary is_temp_table\r\n   FROM\r\n       DBA_HIST_ACTIVE_SESS_HISTORY S,\r\n       DBA_USERS  U\r\n           ,dba_objects o\r\n WHERE\r\n       S.USER_ID = U.USER_ID\r\n       AND S.USER_ID != 0\r\n           and o.OBJECT_ID=s.CURRENT_OBJ#\r\n    and  s.sample_time >= to_timestamp('&&start_time', 'YYYY-MM-DD HH24:MI')\r\n    and s.sample_time <= to_timestamp('&&end_time', 'YYYY-MM-DD HH24:MI')\r\n   and ((to_char(s.SESSION_ID)='&input') or (upper(S.SQL_PLAN_HASH_VALUE) =upper('&input')) or (upper(U.USERNAME)=upper('&input')) or (upper(S.sql_id) like upper ('&&input%')) or (upper(o.object_name) = upper('&input')))\r\n/
18	Session Hist Top CPU Usage Query	Sess Hist Top CPU Usage Query (show_hist_top_cpu_usage)	SET TERMOUT OFF;\r\nCOLUMN current_instance NEW_VALUE current_instance NOPRINT;\r\nCOLUMN db_unique_name NEW_VALUE db_unique_name NOPRINT;\r\nCOLUMN current_timestamp NEW_VALUE current_timestamp  NOPRINT;\r\nSELECT rpad(sys_context('USERENV', 'DB_UNIQUE_NAME'),15)  db_unique_name  FROM DUAL;\r\nSELECT rpad(instance_name, 17) current_instance,rpad(to_char(current_timestamp,'DD-MON-YY HH24:MI'),17) current_timestamp FROM v$instance;\r\nSET TERMOUT ON\r\nSET VERIFY      OFF\r\n\r\nset linesize 160\r\nset pagesize 40\r\n--clear columns\r\n--clear breaks\r\ndefine start_time='&1'\r\ndefine end_time='&2'\r\nttitle off\r\n\r\n\r\nPROMPT\r\nPROMPT +---------------------------------------------------------------------+\r\nPROMPT   Report   : History session  of Top 5 CPU Utilized Query\r\nPROMPT   Duration : Between &start_time and &end_time \r\nPROMPT   DB_Name  : &db_unique_name\r\nPROMPT   Timestamp: &current_timestamp\r\nPROMPT +---------------------------------------------------------------------+\r\n\r\n\r\n\r\n\r\ncolumn usr                 format a11       Heading 'User'\r\ncolumn INSTANCE_NUMBER     format 9      heading 'I|N|S'\r\ncolumn SESSION_ID          format 9999      heading 'S|I|D'\r\ncolumn SQL_PLAN_HASH_VALUE format A10       heading 'SQL PLAN|HASH_VALUE'\r\ncolumn stat                format A1        heading 'S|t|a|t'\r\ncolumn serial              format 9999999   heading 'Serial#'\r\ncolumn machine             format A24       heading 'Machine'\r\ncolumn program             format A16       heading 'Program'\r\ncolumn physical_reads      format 999999999 heading 'Physical|Reads'\r\ncolumn chgs                format A9        heading 'Logical|  Chgs'\r\ncolumn Block_sess          format A6 heading 'Blk|sess'\r\ncolumn module              format A16       heading 'Module'\r\ncolumn Obj_name            format A16       heading 'Obj|Name'\r\ncolumn wait_class           format A10       heading 'Wait Class'\r\ncolumn Time_Waited          format A10       heading 'Time|Waited'\r\ncolumn instance            format A13       heading 'Inst:|Sid,Serial#'\r\ncolumn sql_id              format A13       heading 'SQL ID'\r\nselect * from (\r\nselect \r\n\tSQL_ID, \r\n\tsum(CPU_TIME_DELTA), \r\n\tsum(DISK_READS_DELTA),\r\n\tcount(*)\r\nfrom \r\n\tDBA_HIST_SQLSTAT a, dba_hist_snapshot s\r\nwhere\r\n s.snap_id = a.snap_id\r\n and s.begin_interval_time  >= to_timestamp('&start_time', 'YYYY-MM-DD HH24:MI')\r\n  and s.end_interval_time   <= to_timestamp('&end_time', 'YYYY-MM-DD HH24:MI')\r\n\tgroup by \r\n\tSQL_ID\r\norder by \r\n\tsum(CPU_TIME_DELTA) desc)\r\nwhere rownum < 6\r\n/
11	Query Plan Change Daily report(days)	All Query Plan Change Daily report(days) (plan_change_daily_report)	SET TERMOUT OFF;\r\nCOLUMN current_instance NEW_VALUE current_instance NOPRINT;\r\nCOLUMN db_unique_name NEW_VALUE db_unique_name NOPRINT;\r\nCOLUMN current_timestamp NEW_VALUE current_timestamp  NOPRINT;\r\nSELECT rpad(sys_context('USERENV', 'DB_UNIQUE_NAME'),15)  db_unique_name  FROM DUAL;\r\nSELECT rpad(instance_name, 17) current_instance,rpad(current_timestamp,22) current_timestamp FROM v$instance;\r\nSET TERMOUT ON\r\nset verify off\r\ndefine num_days=&1\r\nPROMPT\r\nPROMPT +------------------------------------------------------------------------------------------------+\r\nPROMPT | Report   : List of SQL id whose plan changed since last &num_days days and  Best Plan can \r\nPROMPT |  \t    improve more than 50% Execution Time compare to Latest plan\t\t\t\r\nPROMPT | DB_Name  : &db_unique_name          \t\t\t\t\t\t\r\nPROMPT | Timestamp: &current_timestamp         \t\t\t\t\t\r\nPROMPT +------------------------------------------------------------------------------------------------+\r\n\r\nset sqlblanklines on\r\nset lines 800 \r\nset pages 100\r\ncol elapsed_per_exec_thisplan for 999.99 heading 'This Plan|AVG_ETIME'\r\ncol elapsed_per_exec_diff     for 999.99 heading 'Diff Plan|AVG_ETIME'\r\ncol elapsed_per_exec_diff_pct for 990.90 heading 'Diff Plan|Improve %'\r\ncol plan_hash_value for 9999999999 heading 'Plan|Hash Value'\r\ncol snap_count for 999 heading 'Snap|Cnt'\r\n--col total_execs for 999999 heading 'Total|Exec'\r\ncol XPLAN for a100 heading 'Get Execution Plan Qry'\r\nbreak on sql_id skip 1\r\n \r\n\r\n/* statements captured during last  days */\r\nwith samples as \r\n (select *\r\n  from dba_hist_sqlstat st\r\n  join dba_hist_snapshot sn\r\n  using (snap_id, instance_number) \r\n  where \r\n  --  sql_id='sqlid'\r\n-- parsing_schema_name = 'schema'\r\n  --and module  'DBMS_SCHEDULER' -- no sql tuning task\r\n   begin_interval_time between sysdate - '&num_days' and sysdate\r\n  and executions_delta > 0),\r\n \r\n\r\n/* just statements that had at least 2 different plans during that time */\r\n  sql_ids as \r\n   (select sql_id,\r\n    count(distinct plan_hash_value) plancount\r\n    from samples\r\n    group by sql_id\r\n    having count(distinct plan_hash_value) > 2),\r\n\r\n/* per combination of sql_id and plan_hash_value, elapsed times per execution */\r\n    plan_stats as \r\n     (select sql_id,\r\n      plan_hash_value,\r\n      min(parsing_schema_name),\r\n      count(snap_id) snap_count,\r\n      max(end_interval_time) last_seen,\r\n      min(begin_interval_time) first_seen,\r\n      sum(executions_delta) total_execs,\r\n      sum(elapsed_time_delta) / sum(executions_delta) elapsed_per_exec_thisplan\r\n      from sql_ids\r\n      join samples\r\n      using (sql_id)\r\n      group by sql_id, plan_hash_value),\r\n\r\n/* how much different is the elapsed time most recently encountered from other elapsed times in the measurement interval? */\r\n      elapsed_time_diffs as \r\n       (select p.*,\r\n        elapsed_per_exec_thisplan - first_value(elapsed_per_exec_thisplan)\r\n          over(partition by sql_id order by last_seen desc) elapsed_per_exec_diff,\r\n        (elapsed_per_exec_thisplan - first_value(elapsed_per_exec_thisplan)\r\n          over(partition by sql_id order by last_seen desc)) / elapsed_per_exec_thisplan elapsed_per_exec_diff_ratio\r\n        from plan_stats p),\r\n\r\n/* consider just statements for which the difference is bigger than our configured threshold */\r\n        impacted_sql_ids as \r\n         (select *\r\n          from elapsed_time_diffs ),\r\n\r\n/* for those statements, get all required information */\r\n          all_info as\r\n           (select sql_id,\r\n            plan_hash_value,\r\n        --    parsing_schema_name,\r\n            snap_count,\r\n            last_seen,\r\n\t\t\tfirst_seen,\r\n\t\t\ttotal_execs,\r\n            round(elapsed_per_exec_thisplan / 1e6, 2) elapsed_per_exec_thisplan,\r\n            round(elapsed_per_exec_diff / 1e6, 2) elapsed_per_exec_diff,\r\n            round(100 * elapsed_per_exec_diff_ratio, 2) elapsed_per_exec_diff_pct,\r\n            round(max(abs(elapsed_per_exec_diff_ratio))\r\n              over(partition by sql_id), 2) * 100 max_abs_diff,\r\n            round(max(elapsed_per_exec_diff_ratio) over(partition by sql_id), 2) * 100 max_diff,\r\n            'select * from table(dbms_xplan.display_awr(sql_id=>''' || sql_id ||\r\n            ''', plan_hash_value=>' || plan_hash_value || '));' xplan\r\n            from elapsed_time_diffs\r\n            where sql_id in (select sql_id from impacted_sql_ids))\r\n\r\n/* format the output */\r\n            select \r\n             a.sql_id,\r\n\t\t\t\tplan_hash_value,\r\n            -- parsing_schema_name,\r\n             a.snap_count,\r\n\t\t\ttotal_execs,\r\n\t\t     to_char(a.elapsed_per_exec_thisplan, '999999.99') elapsed_per_exec_thisplan,\r\n             to_char(a.elapsed_per_exec_diff, '999999.99') elapsed_per_exec_diff,\r\n             to_char(a.elapsed_per_exec_diff_pct, '999999.99') elapsed_per_exec_diff_pct,\r\n\t\t\tto_char(first_seen, 'dd-mon-yy hh24:mi') first_seen,\r\n\t\t\t to_char(last_seen, 'dd-mon-yy hh24:mi') last_seen\r\n             --xplan\r\n             from all_info a where sql_id in (select distinct sql_id from all_info where elapsed_per_exec_diff_pct < -50)\r\n             order by sql_id, elapsed_per_exec_diff_pct;
16	Latch Wait event	Latch Wait event Check (latch_wait_rac)	SET TERMOUT OFF;\r\nCOLUMN current_instance NEW_VALUE current_instance NOPRINT;\r\nCOLUMN db_unique_name NEW_VALUE db_unique_name NOPRINT;\r\nCOLUMN current_timestamp NEW_VALUE current_timestamp  NOPRINT;\r\nSELECT rpad(sys_context('USERENV', 'DB_UNIQUE_NAME'),15)  db_unique_name  FROM DUAL;\r\nSELECT rpad(instance_name, 17) current_instance,rpad(to_char(current_timestamp,'DD-MON-YY HH24:MI'),17) current_timestamp FROM v$instance;\r\nSET TERMOUT ON\r\n\r\nPROMPT\r\nPROMPT +----------------------------------------------------------+\r\nPROMPT   Report   : Latch Event    \r\nPROMPT   DB_Name  : &db_unique_name \r\nPROMPT   Timestamp: &current_timestamp\r\nPROMPT +----------------------------------------------------------+\r\n\r\nselect /*+ ordered */  w1.username waiting_username, w1.inst_id,w1.sid  waiting_session,\r\n        h1.inst_id,h1.sid  holding_session, h1.username holding_username,\r\n        w.kgllktype lock_or_pin,\r\n        w.kgllkhdl address,\r\n        decode(h.kgllkmod,  0, 'None', 1, 'Null', 2, 'Share', 3, 'Exclusive',\r\n           'Unknown') mode_held,\r\n        decode(w.kgllkreq,  0, 'None', 1, 'Null', 2, 'Share', 3, 'Exclusive',\r\n           'Unknown') mode_requested\r\n  from dba_kgllock w, dba_kgllock h, gv$session w1, gv$session h1\r\n where\r\n  (((h.kgllkmod != 0) and (h.kgllkmod != 1)\r\n     and ((h.kgllkreq = 0) or (h.kgllkreq = 1)))\r\n   and\r\n     (((w.kgllkmod = 0) or (w.kgllkmod= 1))\r\n     and ((w.kgllkreq != 0) and (w.kgllkreq != 1))))\r\n  and  w.kgllktype       =  h.kgllktype\r\n  and  w.kgllkhdl        =  h.kgllkhdl\r\n  and  w.kgllkuse     =   w1.saddr\r\n  and  h.kgllkuse     =   h1.saddr\r\n/
9	ASH report (SID)	ASH report generation details(SID) SH File	ASH report generation details(SID) SH File
27	Awr report for single/multi snap comparison	awr report for single/multi snap comparison	awr report for single/multi snap comparison
10	Sql plan stats for sql_id from awr	sql plan stats for sql_id from awr (k_awrsqrpi)	sql plan stats for sql_id from awr (k_awrsqrpi)
7	Stale Stats for sql_id	Stale Stats for sql_id (stale_stat_sqlid)	define sqlid='&1'\r\nSET TERMOUT OFF;\r\nCOLUMN current_instance NEW_VALUE current_instance NOPRINT;\r\nCOLUMN db_unique_name NEW_VALUE db_unique_name NOPRINT;\r\nCOLUMN current_timestamp NEW_VALUE current_timestamp  NOPRINT;\r\nSELECT rpad(sys_context('USERENV', 'DB_UNIQUE_NAME'),15)  db_unique_name  FROM DUAL;\r\nSELECT rpad(instance_name, 17) current_instance,rpad(to_char(current_timestamp,'DD-MON-YY HH24:MI'),17) current_timestamp FROM v$instance;\r\nSET TERMOUT ON\r\n\r\nPROMPT\r\nPROMPT +----------------------------------------------------------+\r\nPROMPT   Report   : Stale stats for sqlid: &sqlid    \r\nPROMPT   DB_Name  : &db_unique_name \r\nPROMPT   Timestamp: &current_timestamp\r\nPROMPT +----------------------------------------------------------+\r\n\r\n--set term off\r\nset pagesize 2000\r\nset long 20000\r\n\r\n\r\nset heading on\r\nset verify off\r\nset feedback off\r\n\r\n\r\ncol table_owner for a15\r\ncol table_name for a30\r\ncol partition_name for a30\r\nselect distinct b.table_owner, b.table_name, b.partition_name, b.inserts, b.updates, b.deletes, b.TRUNCATED,c.STALE_STATS,\r\nto_char(b.timestamp, 'mm/dd/yyyy hh24:mi') timestamp, to_char(c.last_analyzed, 'mm/dd/yyyy hh24:mi') last_analyzed,\r\nc.num_rows\r\nfrom (select distinct sql_id, object#, object_name, object_owner from gv$sql_plan where sql_id = '&&sqlid' UNION select distinct sql_id, object#, object_name, object_owner from dba_hist_sql_plan where sql_id = '&&sqlid') a\r\n, sys.dba_tab_modifications b, dba_tab_statistics c\r\nwhere a.sql_id = '&&sqlid'\r\nand  a.OBJECT_OWNER = b.table_owner\r\nand  a.OBJECT_NAME = b.table_name\r\nand  b.table_owner = c.owner\r\nand  b.table_name  = c.table_name\r\nand  NVL(b.partition_name,'NONE') = NVL(c.partition_name,'NONE')\r\nand b.table_name is not null\r\norder by b.table_owner, b.table_name, b.partition_name;
32	Long Open(Active/Inactive) Transaction	Long Open(Active/Inactive) Transaction (long_open_trans)	SET TERMOUT OFF;\r\nCOLUMN current_instance NEW_VALUE current_instance NOPRINT;\r\nCOLUMN db_unique_name NEW_VALUE db_unique_name NOPRINT;\r\nCOLUMN current_timestamp NEW_VALUE current_timestamp  NOPRINT;\r\nSELECT rpad(sys_context('USERENV', 'DB_UNIQUE_NAME'),15)  db_unique_name  FROM DUAL;\r\nSELECT rpad(instance_name, 17) current_instance,rpad(current_timestamp,22) current_timestamp FROM v$instance;\r\nSET TERMOUT ON\r\n\r\nPROMPT\r\nPROMPT +------------------------------------------------------------------------+\r\nPROMPT | Report   : Long Active/Inactive Transactions                           |\r\nPROMPT | DB_Name  : &db_unique_name                                             |\r\nPROMPT | Timestamp: &current_timestamp                                          |\r\nPROMPT +------------------------------------------------------------------------+\r\n\r\n\r\n-- Connect to source database\r\nset lines 300\r\nset heading on\r\ncolumn username  for a25\r\ncolumn inst_id for 9999 heading 'Inst'\r\ncolumn transaction_duration  format a41\r\nwith transaction_details as\r\n( select inst_id\r\n  , ses_addr\r\n  , sysdate - start_date as diff\r\n  from gv$transaction\r\n)\r\nselect s.username\r\n, to_char(trunc(t.diff))\r\n             || ' days, '\r\n             || to_char(trunc(mod(t.diff * 24,24)))\r\n             || ' hours, '\r\n             || to_char(trunc(mod(t.diff * 24 * 60,24)))\r\n             || ' minutes, '\r\n             || to_char(trunc(mod(t.diff * 24 * 60 * 60,60)))\r\n             || ' seconds' as transaction_duration\r\n, s.program\r\n, s.status\r\n, s.inst_id\r\n, s.sid\r\n, s.serial#\r\nfrom gv$session s\r\n, transaction_details t\r\nwhere s.inst_id = t.inst_id\r\nand s.saddr = t.ses_addr\r\norder by t.diff desc;
23	Query specific history sessions	Query specific history sessions	set markup html on\r\nREM   Show Query execution history with total run time \r\nSET TERMOUT OFF;\r\nCOLUMN current_instance NEW_VALUE current_instance NOPRINT;\r\nCOLUMN db_unique_name NEW_VALUE db_unique_name NOPRINT;\r\nCOLUMN current_timestamp NEW_VALUE current_timestamp  NOPRINT;\r\nSELECT rpad(sys_context('USERENV', 'DB_UNIQUE_NAME'),15)  db_unique_name  FROM DUAL;\r\nSELECT rpad(instance_name, 17) current_instance,rpad(to_char(current_timestamp,'DD-MON-YY HH24:MI'),17) current_timestamp FROM v$instance;\r\nSET TERMOUT ON\r\n\r\ndefine input='&1'\r\ndefine start_time='&2'\r\ndefine end_time='&3' \r\n\r\nPROMPT\r\nPROMPT +--------------------------------------------------------------------------------------+\r\nPROMPT   Report   : Execution History of sql_id &1 \r\nPROMPT   Duration : Between &start_time and &end_time \r\nPROMPT   DB_Name  : &db_unique_name\r\nPROMPT   Timestamp: &current_timestamp\r\nPROMPT +--------------------------------------------------------------------------------------+\r\n\r\n\r\nset linesize 180\r\nset pagesize 40\r\n--clear columns\r\n--clear breaks\r\n\r\nttitle off\r\n\r\ncolumn usr                 format a11       Heading 'User'\r\ncolumn INSTANCE_NUMBER     format 9      heading 'I|N|S'\r\ncolumn SESSION_ID          format 9999      heading 'S|I|D'\r\ncolumn SQL_PLAN_HASH_VALUE format A10       heading 'SQL PLAN|HASH_VALUE'\r\ncolumn stat                format A1        heading 'S|t|a|t'\r\ncolumn serial              format 9999999   heading 'Serial#'\r\ncolumn machine             format A18       heading 'Machine'\r\ncolumn program             format A16       heading 'Program'\r\ncolumn physical_reads      format 999999999 heading 'Physical|Reads'\r\ncolumn chgs                format A9        heading 'Logical|  Chgs'\r\ncolumn Block_sess          format A6 heading 'Blk|sess'\r\ncolumn module              format A16       heading 'Module'\r\ncolumn Obj_name            format A24       heading 'Obj|Name'\r\ncolumn wait_class           format A10       heading 'Wait Class'\r\ncolumn Time_Waited          format A8       heading 'Time|Waited'\r\ncolumn instance            format A12       heading 'Inst:|Sid,Serial#'\r\ncolumn sql_id              format A13       heading 'SQL ID'\r\n-- column SQL_CHILD_NUMBER  format   9999999       heading 'SQL Child'\r\ncolumn SESSION_STATE     format A9       heading 'Sess Stat'\r\ncolumn wait_events      format A19       heading 'Sess Event'\r\nset verify off\r\n\r\ncol total_time format a25 heading 'Total Exec Time'\r\ncol start_time for a18 heading 'Query Start Time'\r\ncol end_time for a18 heading 'Query End Time'\r\nselect s.sql_id,s.SQL_EXEC_ID,to_char(MIN(S.SQL_EXEC_START),'DD-MON-YYYY:HH24:MI') start_time,\r\n\tto_char(MAX(S.SAMPLE_TIME),'DD-MON-YYYY:HH24:MI') end_time, \r\n  \tto_char(MAX(S.SAMPLE_TIME)-MIN(S.SQL_EXEC_START),'HH24:MI:SS') total_time \r\n--\tto_char(((MAX(S.SAMPLE_TIME) -MIN(S.SQL_EXEC_START)),'HH24:MI')/1000000)  total_sec \r\nFROM DBA_HIST_ACTIVE_SESS_HISTORY S\r\nWHERE s.sample_time >= to_timestamp('&start_time', 'YYYY-MM-DD HH24:MI')\r\n  and s.sample_time <= to_timestamp('&end_time', 'YYYY-MM-DD HH24:MI')\r\n  and s.sql_id = '&input'\r\ngroup by s.sql_id,SQL_EXEC_ID\r\norder by 1,2\r\n/
6	SQL text(sql_id)	SQL Text(sql_id)	set linesize 200\r\n--set term off\r\nset pagesize 2000\r\nset long 20000\r\nset verify off\r\ndefine sql_id='&1'\r\ncol SQL_FULLTEXT format A200\r\nprompt\r\nprompt +------------------------------------------+\r\nprompt SQL Text of &sql_id from Cursor Cache\r\nprompt +------------------------------------------+\r\nprompt\r\nselect SQL_FULLTEXT from v$sqlarea where sql_id='&sql_id';\r\nprompt \r\nprompt +------------------------------------------+\r\nprompt  SQL Text of &sql_id from History\r\nprompt +------------------------------------------+\r\nprompt\r\nselect sql_text from DBA_HIST_SQLTEXT where  sql_id='&sql_id';
29	Active All Sessions	Active Sessions	SET TERMOUT OFF;\r\nCOLUMN current_instance NEW_VALUE current_instance NOPRINT;\r\nCOLUMN db_unique_name NEW_VALUE db_unique_name NOPRINT;\r\nCOLUMN current_timestamp NEW_VALUE current_timestamp  NOPRINT;\r\nSELECT rpad(sys_context('USERENV', 'DB_UNIQUE_NAME'),15)  db_unique_name  FROM DUAL;\r\nSELECT rpad(instance_name, 17) current_instance,rpad(to_char(current_timestamp,'DD-MON-YY HH24:MI'),17) current_timestamp FROM v$instance;\r\nSET TERMOUT ON\r\n\r\nPROMPT\r\nPROMPT +------------------------------------------------------------------------+\r\nPROMPT   Report   \t: Show Active Sessions(User:&1)\r\nPROMPT   DB_Name  \t: &db_unique_name\r\nPROMPT   Report Time\t: &current_timestamp\r\nPROMPT +------------------------------------------------------------------------+\r\n\r\nset linesize 200\r\nset pagesize 2000\r\nclear columns\r\nclear breaks\r\ndefine input=&1\r\nttitle off\r\n\r\ncolumn usr                 format a25       Heading 'Osuser  /Prg'\r\n#column sid                 format 9999      heading 'S|I|D'\r\ncolumn inst                format 999       heading 'Inst|ID'\r\ncolumn connected           format A19       heading 'Connected'\r\ncolumn stat                format A1        heading 'S|t|a|t'\r\n#column serial              format 9999999   heading 'Serial#'\r\ncolumn machine             format A25       heading 'Machine'\r\ncolumn logical             format A19       heading '      Logical|    Gets / Chgs'\r\ncolumn physical_reads      format 999999999 heading 'Physical|Reads'\r\ncolumn chgs                format A9        heading 'Logical|  Chgs'\r\ncolumn consistent_changes  format 999999999 heading 'Consist|Changes'\r\ncolumn module              format A25       heading 'Module'\r\ncolumn service             format A20       heading 'Service'\r\ncol sess for a12 heading 'SID|Serial#'\r\n\r\nset verify off\r\nSELECT rpad(p.username,8)||'/'||\r\n       rpad(p.program,15) Usr,\r\n    --    substr(p.program,instr(p.program,' ')) Usr,\r\n\ts.inst_id inst,\r\n\t'('||s.sid||','||s.serial#||')' sess,\r\n       --TO_CHAR(S.LOGON_TIME,'YYYY-MM-DD HH24:MI:SS') connected,\r\n       substr(S.STATUS,1,1) STAT,\r\n       substr(p.program,instr(p.program,'@')+1,\r\n              instr(p.program,' ')-instr(p.program,'@')) MACHINE,\r\n       lpad(to_char(I.BLOCK_GETS+I.CONSISTENT_GETS),9)||'/'||\r\n       lpad(to_char(I.BLOCK_CHANGES+I.CONSISTENT_CHANGES),9) logical,\r\n       I.PHYSICAL_READS, \r\n       substr(S.MODULE,1,25) module,\r\n       substr(S.SERVICE_NAME,1,20) service,s.sql_id\r\n  FROM\r\n       GV$SESSION S,\r\n       GV$SESS_IO I, \r\n       GV$PROCESS P\r\n WHERE\r\n        S.INST_ID=I.INST_ID \r\n   AND  S.INST_ID=P.INST_ID \r\n   AND  S.SID = I.SID\r\n   AND S.USER# = 0\r\n   AND S.TYPE = 'USER'\r\n   AND S.TERMINAL IS NULL\r\n   AND S.PROGRAM IS NULL\r\n   AND S.PADDR = P.ADDR AND S.STATUS='ACTIVE'\r\n   AND (upper(s.username) like upper('%&input%'))\r\nUNION\r\n-- Users\r\nSELECT rpad(S.OSUSER,8)||'/'||rpad(S.USERNAME,10) Usr,\r\n\ts.inst_id inst,\r\n\t '('||s.sid||','||s.serial#||')' sess,\r\n       --TO_CHAR(S.LOGON_TIME,'YYYY-MM-DD HH24:MI:SS') connected,\r\n       substr(S.STATUS,1,1) STAT,\r\n       substr(S.MACHINE,1,29) MACHINE,\r\n       lpad(to_char(I.BLOCK_GETS+I.CONSISTENT_GETS),9)||'/'||\r\n       lpad(to_char(I.BLOCK_CHANGES+I.CONSISTENT_CHANGES),9) logical,\r\n       I.PHYSICAL_READS, \r\n       substr(S.MODULE,1,25) module,\r\n\tsubstr(S.SERVICE_NAME,1,20) service,s.sql_id\r\n  FROM\r\n       GV$SESSION S,\r\n       GV$SESS_IO I\r\n WHERE\r\n        S.INST_ID=I.INST_ID\r\n   AND S.SID = I.SID\r\n   AND S.USER# != 0  AND S.STATUS='ACTIVE'\r\n   AND (upper(s.username) like upper('%&input%'))\r\n ORDER BY 2,3;
34	Wait class,event,sql_id between snap	Wait class,event,sql_id between snap	Wait class,event,sql_id between snap
99	Interactive Sql Monitor	Interactive Sql Monitor - sub menu	Interactive Sql Monitor - sub menu
40	View History Log Files	List of all the log files which is generated during execution of this application	List of all the log files which is generated during execution of this application
8	Kill Session/Purge Plan Syntax (sid)	Kill Session/Purge Plan(sid) (sess_kill)	SET TERMOUT OFF;\r\nCOLUMN current_instance NEW_VALUE current_instance NOPRINT;\r\nCOLUMN db_unique_name NEW_VALUE db_unique_name NOPRINT;\r\nCOLUMN current_timestamp NEW_VALUE current_timestamp  NOPRINT;\r\nSELECT rpad(sys_context('USERENV', 'DB_UNIQUE_NAME'),15)  db_unique_name  FROM DUAL;\r\nSELECT rpad(instance_name, 17) current_instance,rpad(to_char(current_timestamp,'DD-MON-YY HH24:MI'),17) current_timestamp FROM v$instance;\r\nSET TERMOUT ON\r\ndefine sqlid=&1\r\n \r\nPROMPT\r\nPROMPT +--------------------------------------------------------------------------------------+\r\nPROMPT   Report   : Session Kill syntax\r\nPROMPT   sql_id   : &1 \r\nPROMPT   DB_Name  : &db_unique_name\r\nPROMPT   Timestamp: &current_timestamp\r\nPROMPT +--------------------------------------------------------------------------------------+\r\n\r\n\r\n\r\n\r\nset pagesize 100\r\n\r\nset feed off\r\nset linesize 100\r\nset pagesize 0\r\nset verify off\r\nPROMPT\r\nPROMPT +---------------------------------------------------------------------------+\r\nPROMPT   Session Kill syntax for all existing users running with sql_id &sqlid\r\nPROMPT +---------------------------------------------------------------------------+\r\nselect 'ALTER SYSTEM KILL SESSION '||''''||SID||','||SERIAL#||',@'||INST_ID||''''||' IMMEDIATE;'\r\nfrom gv$session \r\nwhere \r\n sql_id = '&&sqlid'\r\n --sql_id like lower('&&sqlid')\r\nand status <>  'KILLED'\r\norder by inst_id,sid,serial#\r\n/\r\nPROMPT\r\nPROMPT\r\nPROMPT +------------------------------------------------------------------------+\r\nPROMPT | FLUSH PLAN QUERY SYNTAX                                                |\r\nPROMPT +------------------------------------------------------------------------+\r\nselect 'exec sys.dbms_shared_pool.purge('''||address||','||hash_value||''',''c'',1);' Flush_Plan_Syntax  from v$sqlarea where sql_id like '&&sqlid'\r\n/
19	Session Hist Top Obj Wait	Hist Top Obj Wait (show_hist_top_obj_wait)	SET TERMOUT OFF;\r\nCOLUMN current_instance NEW_VALUE current_instance NOPRINT;\r\nCOLUMN db_unique_name NEW_VALUE db_unique_name NOPRINT;\r\nCOLUMN current_timestamp NEW_VALUE current_timestamp  NOPRINT;\r\nSELECT rpad(sys_context('USERENV', 'DB_UNIQUE_NAME'),15)  db_unique_name  FROM DUAL;\r\nSELECT rpad(instance_name, 17) current_instance,rpad(to_char(current_timestamp,'DD-MON-YY HH24:MI'),17) current_timestamp FROM v$instance;\r\nSET TERMOUT ON\r\n\r\nset verify off\r\nset linesize 160\r\nset pagesize 40\r\n--clear columns\r\n--clear breaks\r\ndefine start_time='&1'\r\ndefine end_time='&2'\r\nttitle off\r\n \r\n\r\nPROMPT\r\nPROMPT +--------------------------------------------------------------------------------------+\r\nPROMPT   Report   : History session  of Top 5 Object wait\r\nPROMPT   Duration : Between &start_time and &end_time \r\nPROMPT   DB_Name  : &db_unique_name\r\nPROMPT   Timestamp: &current_timestamp\r\nPROMPT +--------------------------------------------------------------------------------------+\r\n\r\n\r\n\r\ncol event format a40\r\ncol object_name format a40\r\n\r\nselect * from \r\n(\r\n  select dba_objects.object_name,\r\n dba_objects.object_type,\r\nactive_session_history.event,\r\n sum(active_session_history.wait_time +\r\n  active_session_history.time_waited) ttl_wait_time\r\nfrom gv$active_session_history active_session_history,\r\n    dba_objects\r\n where \r\n  active_session_history.sample_time >= to_timestamp('&start_time', 'YYYY-MM-DD HH24:MI')\r\n  and active_session_history.sample_time <= to_timestamp('&end_time', 'YYYY-MM-DD HH24:MI')\r\nand active_session_history.current_obj# = dba_objects.object_id\r\n group by dba_objects.object_name, dba_objects.object_type, active_session_history.event\r\n order by 4 desc)\r\nwhere rownum < 6;
39	Database Service Status	DB Service Status (db_service_all)	SET TERMOUT OFF;\r\nCOLUMN current_instance NEW_VALUE current_instance NOPRINT;\r\nCOLUMN db_unique_name NEW_VALUE db_unique_name NOPRINT;\r\nCOLUMN current_timestamp NEW_VALUE current_timestamp  NOPRINT;\r\nSELECT rpad(sys_context('USERENV', 'DB_UNIQUE_NAME'),15)  db_unique_name  FROM DUAL;\r\nSELECT rpad(instance_name, 17) current_instance,rpad(to_char(current_timestamp,'DD-MON-YY HH24:MI'),17) current_timestamp FROM v$instance;\r\nSET TERMOUT ON\r\n\r\nPROMPT\r\nPROMPT +--------------------------------+\r\nPROMPT   Report   : DB Service Details\r\nPROMPT   DB_Name  : &db_unique_name\r\nPROMPT   Timestamp: &current_timestamp\r\nPROMPT +--------------------------------+\r\n\r\n\r\n-- view load balancing goal of a current service\r\n-- NONE means load balancing advisory is disabled\r\nPROMPT +-------------+\r\nPROMPT TOTAL SERVICES\r\nPROMPT +-------------+\r\nset linesize 200\r\nset pagesize 2000\r\nSELECT NAME Service_name, GOAL, CLB_GOAL FROM DBA_SERVICES order by 1;\r\n\r\n\r\nPROMPT +-----------+\r\nPROMPT  SERVICES\r\nPROMPT +-----------+\r\n-- aggregated\r\ncol cpu_percall for 99999999 heading "CPU |Minute |per call"\r\ncol elap_time for 99999999 heading "Elapsed |Minute| per call"\r\ncol user_call for 99999999 heading  "User Calls/s"\r\ncol db_time for 99999999 heading "DB Time/s"\r\ncol group_id for 99  heading "Service|Metric|Group"\r\ncol service_name for a40\r\nSELECT\r\nrpad(service_name,40) service_name, group_id,\r\nround(sum(CPUPERCALL)/60,2) cpu_percall,\r\nround(sum(DBTIMEPERCALL)/60,2) elap_time, \r\nround(sum(CALLSPERSEC),2) user_call,\r\nround(sum(DBTIMEPERSEC),2) db_time\r\nfrom V$SERVICEMETRIC_HISTORY\r\ngroup by SERVICE_NAME, group_id\r\nhaving round(sum(CPUPERCALL)/60,2) > 0\r\norder by 3 desc;\r\n\r\nPROMPT  TAF failover\r\n-- TAF failover \r\ncol machine for a30\r\ncol service_name for a27\r\nSELECT rpad(machine,30) machine, failover_method, failover_type,\r\nfailed_over, rpad(service_name,27) service_name, COUNT(*)\r\nFROM gv$session\r\nGROUP BY machine, failover_method, failover_type,\r\nfailed_over, service_name\r\norder by 6 desc;\r\n\r\n\r\nPROMPT +----------------------------------+\r\nPROMPT  Failed Over Service Detail\r\nPROMPT +----------------------------------+\r\n\r\ncol inst_id for 9999 head "Inst|id"\r\ncol username for a15\r\ncol "session" for a12 head "Sid|Serial#"\r\ncol service_name for a30 \r\nselect\r\n   substr(service_name,1,30) service_name,\r\n   username, \r\n   inst_id,sid||':'||serial# "session",\r\n   failover_type, \r\n   failover_method, \r\n   failed_over,\r\n   to_char(prev_exec_start,'mm/dd/yyyy hh24:mi') prev_exec_start,\r\n   to_char(logon_time,'mm/dd/yyyy hh24:mi') logon_time\r\nfrom\r\n   gv$session\r\nwhere\r\n   username not in ('SYS','SYSTEM','PERFSTAT')\r\nand\r\n   failed_over = 'YES' order by service_name;
\.


--
-- Data for Name: django_admin_log; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.django_admin_log (id, action_time, object_id, object_repr, action_flag, change_message, content_type_id, user_id) FROM stdin;
1	2018-08-20 17:48:37.527+05:30	1	Khatoi, Pabitra	1	[{"added": {}}]	7	1
2	2018-08-20 17:49:20.206+05:30	2	Rengarajan, Sudharsan	1	[{"added": {}}]	7	1
3	2018-08-20 17:50:02.891+05:30	3	Venugopal, Arun	1	[{"added": {}}]	7	1
4	2018-08-20 17:50:31.628+05:30	4	Deepika, Deepika	1	[{"added": {}}]	7	1
5	2018-08-20 17:50:55.146+05:30	5	Varia, Ketan	1	[{"added": {}}]	7	1
6	2018-08-20 17:51:21.547+05:30	6	Shaikh, Nawaz	1	[{"added": {}}]	7	1
7	2018-08-20 17:52:10.273+05:30	1	Software	1	[{"added": {}}]	10	1
8	2018-08-20 17:52:56.447+05:30	1	English	1	[{"added": {}}]	11	1
9	2018-08-20 17:53:02.539+05:30	1	Computer Science	1	[{"added": {}}]	8	1
10	2018-08-20 17:53:49.697+05:30	2	Economics	1	[{"added": {}}]	10	1
11	2018-08-20 17:53:56.756+05:30	2	Economics	1	[{"added": {}}]	8	1
12	2018-08-20 17:55:32.872+05:30	3	Social	1	[{"added": {}}]	10	1
13	2018-08-20 17:55:42.543+05:30	2	Hindi	1	[{"added": {}}]	11	1
14	2018-08-20 17:55:45.127+05:30	3	Autobiography of Vivekanand	1	[{"added": {}}]	8	1
15	2018-08-20 17:56:07.508+05:30	4	Games	1	[{"added": {}}]	10	1
16	2018-08-20 18:06:47.442+05:30	bea262ee-f8a5-49ff-8b9b-29e3444a4fb0	bea262ee-f8a5-49ff-8b9b-29e3444a4fb0 (Computer Science)	1	[{"added": {}}]	9	1
17	2018-08-20 18:07:00.945+05:30	636b5f61-d2cd-4738-9652-2ca3a6f02018	636b5f61-d2cd-4738-9652-2ca3a6f02018 (Economics)	1	[{"added": {}}]	9	1
18	2018-08-20 18:07:23.825+05:30	4533162a-007e-4587-a84e-bfb657a6bd6d	4533162a-007e-4587-a84e-bfb657a6bd6d (Autobiography of Vivekanand)	1	[{"added": {}}]	9	1
19	2018-08-21 08:03:54.942+05:30	4	social science	1	[{"added": {}}]	8	1
20	2018-08-21 08:04:30.697+05:30	5	Mathematics	1	[{"added": {}}]	8	1
21	2018-08-21 08:05:20.782+05:30	6	Indian History	1	[{"added": {}}]	8	1
22	2018-08-21 08:06:13.33+05:30	7	Chess	1	[{"added": {}}]	8	1
23	2018-08-21 10:15:01.552+05:30	bea262ee-f8a5-49ff-8b9b-29e3444a4fb0	bea262ee-f8a5-49ff-8b9b-29e3444a4fb0 (Computer Science)	2	[{"changed": {"fields": ["borrower"]}}]	9	1
24	2018-08-21 22:05:20.672+05:30	7	Chess	2	[{"added": {"name": "book instance", "object": "de889212-395e-479c-9aaa-f44b48071ee8 (Chess)"}}]	8	1
25	2018-08-21 22:05:53.369+05:30	5	Mathematics	2	[{"added": {"name": "book instance", "object": "2d0ae8fe-474a-4fc7-9ff2-b0e56242bfbb (Mathematics)"}}, {"added": {"name": "book instance", "object": "69ddd485-a2b1-4cec-89d2-28751c21eb07 (Mathematics)"}}]	8	1
26	2018-08-22 08:47:17.288+05:30	1	1, Get Session(SID/Username/OS-User/Module)	1	[{"added": {}}]	12	1
27	2018-08-22 08:47:47.439+05:30	2	2, SQL CurrPlan(sql_id)	1	[{"added": {}}]	12	1
28	2018-08-22 08:48:11.898+05:30	3	3, Long Query(sql_id)	1	[{"added": {}}]	12	1
29	2018-08-22 08:48:41.965+05:30	4	4, SQl Plan(sql_id)	1	[{"added": {}}]	12	1
30	2018-08-22 08:49:06.97+05:30	5	5, SQL Advisor(sql_id)	1	[{"added": {}}]	12	1
31	2018-08-22 08:49:30.621+05:30	6	6, SQL Text(sql_id)	1	[{"added": {}}]	12	1
32	2018-08-22 08:49:52.29+05:30	7	7, Session detail(SID)	1	[{"added": {}}]	12	1
33	2018-08-22 08:50:16.278+05:30	8	8, SQL-DIAG(sql_id)	1	[{"added": {}}]	12	1
34	2018-08-22 08:50:35.223+05:30	9	9, High-CPU Sessions	1	[{"added": {}}]	12	1
35	2018-08-22 08:50:53.981+05:30	10	10, Active Sessions	1	[{"added": {}}]	12	1
36	2018-08-22 10:13:49.72+05:30	7	Chess	2	[{"changed": {"fields": ["task_name"]}}]	8	1
37	2018-08-22 10:13:57.913+05:30	6	Indian History	2	[{"changed": {"fields": ["task_name"]}}]	8	1
38	2018-08-22 10:14:07.559+05:30	5	Mathematics	2	[{"changed": {"fields": ["task_name"]}}]	8	1
39	2018-08-22 10:14:16.429+05:30	4	social science	2	[{"changed": {"fields": ["task_name"]}}]	8	1
40	2018-08-22 10:14:28.441+05:30	3	Autobiography of Vivekanand	2	[{"changed": {"fields": ["task_name"]}}]	8	1
41	2018-08-27 14:41:46.285+05:30	4	Physics	2	[{"changed": {"fields": ["title"]}}]	8	1
42	2018-08-28 10:29:56.163+05:30	11	11, DML-Active Session	1	[{"added": {}}]	12	1
43	2018-08-28 10:31:20.771+05:30	12	12, All Session(Active+Inactive+Sys)	1	[{"added": {}}]	12	1
44	2018-08-28 10:32:08.571+05:30	13	13, Show All Blocking if exist	1	[{"added": {}}]	12	1
45	2018-08-28 10:33:07.457+05:30	14	14, Show All History session details	1	[{"added": {}}]	12	1
46	2018-08-28 10:33:57.474+05:30	15	15, Tablespace free space with autoextend(TABLESPACE)	1	[{"added": {}}]	12	1
47	2018-08-28 14:41:23.883+05:30	16	16, Temp Tablespace space	1	[{"added": {}}]	12	1
48	2018-08-28 14:41:36.997+05:30	16	16, Temp Tablespace space	2	[]	12	1
49	2018-08-28 14:41:41.94+05:30	16	16, Temp Tablespace space	2	[]	12	1
50	2018-08-28 14:51:42.274+05:30	17	17, Undo space	1	[{"added": {}}]	12	1
51	2018-08-28 14:51:49.156+05:30	17	17, Undo space	2	[]	12	1
52	2018-08-28 14:52:43.532+05:30	18	18, RMAN Backup	1	[{"added": {}}]	12	1
53	2018-08-28 14:53:28.497+05:30	19	19, Table,Index details	1	[{"added": {}}]	12	1
54	2018-08-28 14:54:13.753+05:30	20	20, DB Service Status	1	[{"added": {}}]	12	1
55	2018-08-28 14:54:59.057+05:30	21	21, Gateway/Agent Status	1	[{"added": {}}]	12	1
56	2018-08-28 14:55:39.808+05:30	22	22, ASM DiskGroup Details	1	[{"added": {}}]	12	1
57	2018-08-28 14:56:18.256+05:30	23	23, ASM Disk Performance	1	[{"added": {}}]	12	1
58	2018-08-28 14:56:56.816+05:30	24	24, ADDM report(Between date)	1	[{"added": {}}]	12	1
59	2018-08-28 14:57:48.294+05:30	25	25, Archive Gap	1	[{"added": {}}]	12	1
60	2018-08-28 17:22:59.793+05:30	26	26, Alert log contents	1	[{"added": {}}]	12	1
61	2018-08-28 17:23:33.263+05:30	27	27, Sess Hist Top IO Query	1	[{"added": {}}]	12	1
62	2018-08-28 17:24:27.16+05:30	28	28, Hist Top Obj Wait	1	[{"added": {}}]	12	1
63	2018-08-28 17:25:03.343+05:30	29	29, Sess Hist Top CPU Usage Query	1	[{"added": {}}]	12	1
64	2018-08-28 17:25:50.831+05:30	30	30, Session History-2	1	[{"added": {}}]	12	1
65	2018-08-28 17:26:43.105+05:30	31	31, Kill Session/Purge Plan(sid)	1	[{"added": {}}]	12	1
66	2018-08-28 17:27:23.727+05:30	32	32, sql plan stats for sql_id from awr	1	[{"added": {}}]	12	1
67	2018-08-28 17:28:08.366+05:30	33	33, All Query Plan Change Daily report(days)	1	[{"added": {}}]	12	1
68	2018-08-28 17:44:01.637+05:30	34	34, Wait class,event,sql_id between snap	1	[{"added": {}}]	12	1
69	2018-08-28 17:45:38.436+05:30	35	35, ASH report generation details(SID)	1	[{"added": {}}]	12	1
70	2018-08-28 17:47:37.786+05:30	36	36, Latch Wait event Check	1	[{"added": {}}]	12	1
71	2018-08-28 17:48:24.074+05:30	37	37, Stale Stats for sql_id	1	[{"added": {}}]	12	1
72	2018-08-28 17:49:06.946+05:30	38	38, Long Open(Active/Inactive) Transaction	1	[{"added": {}}]	12	1
73	2018-08-28 17:50:53.594+05:30	39	39, Interactive Sql Monitor	1	[{"added": {}}]	12	1
74	2018-08-28 17:51:53.585+05:30	40	40, Users last 30 min Session History	1	[{"added": {}}]	12	1
75	2018-08-28 17:52:30.001+05:30	41	41, TEMP Usages(user specific)	1	[{"added": {}}]	12	1
258	2018-11-23 17:38:11.519+05:30	43	45, Identify/Pin Good SQL Plan	3		15	1
76	2018-08-28 17:55:26.521+05:30	42	42, Verify Recent Table/Column Struct Change	1	[{"added": {}}]	12	1
77	2018-08-28 17:56:10.512+05:30	43	43, Identify/Pin Good SQL Plan	1	[{"added": {}}]	12	1
78	2018-08-28 17:56:43.127+05:30	44	44, DBA Action Menu	1	[{"added": {}}]	12	1
79	2018-08-28 17:57:58.472+05:30	45	45, AWR Report(Single Snap/Two Snap Comparision)	1	[{"added": {}}]	12	1
80	2018-08-29 06:32:29.193+05:30	de889212-395e-479c-9aaa-f44b48071ee8	de889212-395e-479c-9aaa-f44b48071ee8 (Chess)	2	[{"changed": {"fields": ["status"]}}]	9	1
81	2018-09-03 08:24:24.53+05:30	8	8, System wait event	2	[{"changed": {"fields": ["task_name", "task_summary"]}}]	12	1
82	2018-09-03 09:38:15.837+05:30	15	15, Tablespace free space	2	[{"changed": {"fields": ["task_name"]}}]	12	1
83	2018-09-04 08:13:47.181+05:30	46	46, current sql query monitor details	1	[{"added": {}}]	12	1
84	2018-09-18 08:24:26.148+05:30	2	ketan	1	[{"added": {}}]	4	1
85	2018-09-18 08:25:47.224+05:30	2	ketan	2	[{"changed": {"fields": ["first_name", "last_name", "email", "is_superuser"]}}]	4	1
86	2018-09-18 08:27:38.9+05:30	2	ketan	2	[{"changed": {"fields": ["user_permissions"]}}]	4	1
87	2018-09-21 11:47:22.215+05:30	variakn	Dbaloginuser object (variakn)	1	[{"added": {}}]	13	1
88	2018-09-21 11:53:56.784+05:30	2018-09-21 06:23:23.824653+00:00	Dbaloginuser object (2018-09-21 06:23:23.824653+00:00)	3		13	1
89	2018-09-21 11:54:39.768+05:30	variakn	Dbaloginuser object (variakn)	1	[{"added": {}}]	13	1
90	2018-09-21 11:55:02.982+05:30	variakn_dba	Dbaloginuser object (variakn_dba)	1	[{"added": {}}]	13	1
91	2018-09-22 05:56:02.857+05:30	variakn_dba	Dbaloginuser object (variakn_dba)	2	[{"changed": {"fields": ["user_status"]}}]	13	1
92	2018-09-22 05:57:27.102+05:30	variakn_dba	Dbaloginuser object (variakn_dba)	2	[{"changed": {"fields": ["user_status"]}}]	13	1
93	2018-09-22 18:14:42.912+05:30	45	45, AWR -Single/Comparison Report	2	[{"changed": {"fields": ["task_name"]}}]	12	1
94	2018-09-24 12:45:56.886+05:30	44	44, View History Log Files	2	[{"changed": {"fields": ["task_name", "task_summary"]}}]	12	1
95	2018-09-28 15:15:40.21+05:30	30	30, Session History(with wait time)	2	[{"changed": {"fields": ["task_name", "task_summary"]}}]	12	1
96	2018-11-05 19:20:04.306+05:30	variakn_dba	Dbaloginuser object (variakn_dba)	2	[{"changed": {"fields": ["user_email"]}}]	14	1
97	2018-11-05 19:20:19.031+05:30	variakn	Dbaloginuser object (variakn)	2	[{"changed": {"fields": ["user_email"]}}]	14	1
98	2018-11-06 15:33:06.813+05:30	variakn_dba	Dbaloginuser object (variakn_dba)	3		14	1
99	2018-11-06 15:33:55.553+05:30	loadtest	Dbaloginuser object (loadtest)	1	[{"added": {}}]	14	1
100	2018-11-06 15:34:06.211+05:30	variakn	Dbaloginuser object (variakn)	2	[{"changed": {"fields": ["user_email"]}}]	14	1
101	2018-11-06 16:02:41.367+05:30	ketan	Dbaloginuser object (ketan)	2	[{"changed": {"fields": ["db_user_id"]}}]	14	1
102	2018-11-11 21:35:54.601+05:30	1	1, Get Session(SID/Username/OS-User/Module)	2	[{"changed": {"fields": ["task_summary"]}}]	15	1
103	2018-11-11 22:14:34.027+05:30	1	1, Get Session(SID/Username/OS-User/Module)	2	[{"changed": {"fields": ["task_sqlquery"]}}]	15	1
104	2018-11-12 08:13:31.001+05:30	1	1, Get Session(SID/Username/OS-User/Module)	2	[{"changed": {"fields": ["task_sqlquery"]}}]	15	1
105	2018-11-12 08:27:06.206+05:30	1	1, Get Session(SID/Username/OS-User/Module)	2	[{"changed": {"fields": ["task_sqlquery"]}}]	15	1
106	2018-11-12 08:28:19.143+05:30	1	1, Get Session(SID/Username/OS-User/Module)	2	[{"changed": {"fields": ["task_sqlquery"]}}]	15	1
107	2018-11-12 08:30:40.839+05:30	1	1, Get Session(SID/Username/OS-User/Module)	2	[{"changed": {"fields": ["task_sqlquery"]}}]	15	1
108	2018-11-12 08:46:11.854+05:30	1	1, Get Session(SID/Username/OS-User/Module)	2	[{"changed": {"fields": ["task_sqlquery"]}}]	15	1
109	2018-11-12 09:25:17.724+05:30	2	2, SQL CurrPlan(sql_id)	2	[{"changed": {"fields": ["task_sqlquery"]}}]	15	1
110	2018-11-12 09:25:37.662+05:30	2	2, SQL CurrPlan(sql_id)	2	[{"changed": {"fields": ["task_sqlquery"]}}]	15	1
111	2018-11-12 09:26:03.279+05:30	1	1, Get Session(SID/Username/OS-User/Module)	2	[{"changed": {"fields": ["task_summary"]}}]	15	1
112	2018-11-12 10:09:35.859+05:30	3	3, Long Query(sql_id)	2	[{"changed": {"fields": ["task_sqlquery"]}}]	15	1
113	2018-11-12 10:14:20.816+05:30	4	4, SQl Plan(sql_id)	2	[{"changed": {"fields": ["task_sqlquery"]}}]	15	1
114	2018-11-12 10:18:26.661+05:30	5	5, SQL Advisor(sql_id)	2	[{"changed": {"fields": ["task_sqlquery"]}}]	15	1
115	2018-11-12 10:49:32.01+05:30	6	6, SQL Text(sql_id)	2	[{"changed": {"fields": ["task_sqlquery"]}}]	15	1
116	2018-11-12 10:52:50.209+05:30	7	7, Session detail(SID)	2	[{"changed": {"fields": ["task_sqlquery"]}}]	15	1
117	2018-11-12 11:46:12.961+05:30	8	8, System wait event	2	[{"changed": {"fields": ["task_sqlquery"]}}]	15	1
118	2018-11-12 11:51:54.239+05:30	9	9, High-CPU Sessions	2	[{"changed": {"fields": ["task_sqlquery"]}}]	15	1
119	2018-11-12 11:54:21.609+05:30	10	10, Active Sessions	2	[{"changed": {"fields": ["task_sqlquery"]}}]	15	1
120	2018-11-12 11:59:11.527+05:30	11	11, DML-Active Session	2	[{"changed": {"fields": ["task_sqlquery"]}}]	15	1
121	2018-11-12 12:01:40.976+05:30	12	12, All Session(Active+Inactive+Sys)	2	[{"changed": {"fields": ["task_sqlquery"]}}]	15	1
122	2018-11-12 12:07:01.886+05:30	13	13, Show All Blocking if exist	2	[{"changed": {"fields": ["task_sqlquery"]}}]	15	1
123	2018-11-12 12:08:27.807+05:30	13	13, Show All Blocking if exist	2	[{"changed": {"fields": ["task_sqlquery"]}}]	15	1
124	2018-11-12 12:13:34.876+05:30	13	13, Show All Blocking if exist	2	[{"changed": {"fields": ["task_sqlquery"]}}]	15	1
125	2018-11-12 12:17:12.135+05:30	13	13, Show All Blocking if exist	2	[{"changed": {"fields": ["task_sqlquery"]}}]	15	1
126	2018-11-12 18:31:26.969+05:30	14	14, Show All History session details	2	[{"changed": {"fields": ["task_summary", "task_sqlquery"]}}]	15	1
127	2018-11-12 18:32:50.486+05:30	21	21, show_sess_ops_usr_hist	2	[{"changed": {"fields": ["task_name", "task_summary", "task_sqlquery"]}}]	15	1
128	2018-11-12 18:47:23.566+05:30	15	15, Tablespace free space	2	[{"changed": {"fields": ["task_sqlquery"]}}]	15	1
129	2018-11-12 18:50:05.511+05:30	16	16, Temp Tablespace space	2	[{"changed": {"fields": ["task_sqlquery"]}}]	15	1
130	2018-11-12 18:53:17.102+05:30	17	17, Undo space	2	[{"changed": {"fields": ["task_sqlquery"]}}]	15	1
131	2018-11-12 18:56:14.42+05:30	18	18, RMAN Backup	2	[{"changed": {"fields": ["task_sqlquery"]}}]	15	1
132	2018-11-12 20:10:05.217+05:30	19	19, Table,Index details	2	[{"changed": {"fields": ["task_sqlquery"]}}]	15	1
133	2018-11-12 20:12:47.901+05:30	20	20, DB Service Status	2	[{"changed": {"fields": ["task_sqlquery"]}}]	15	1
134	2018-11-12 20:18:40.272+05:30	22	22, ASM DiskGroup Details	2	[{"changed": {"fields": ["task_sqlquery"]}}]	15	1
135	2018-11-12 20:19:22.811+05:30	23	23, ASM Disk Performance	2	[{"changed": {"fields": ["task_sqlquery"]}}]	15	1
136	2018-11-12 20:19:46.008+05:30	23	23, ASM Disk Performance	2	[{"changed": {"fields": ["task_sqlquery"]}}]	15	1
137	2018-11-12 20:25:40.679+05:30	24	24, ADDM report(Between date)	2	[{"changed": {"fields": ["task_sqlquery"]}}]	15	1
138	2018-11-12 20:28:22.228+05:30	25	25, Archive Gap	2	[{"changed": {"fields": ["task_sqlquery"]}}]	15	1
139	2018-11-12 20:31:16.442+05:30	26	26, Alert log contents	2	[{"changed": {"fields": ["task_sqlquery"]}}]	15	1
140	2018-11-12 21:05:24.84+05:30	27	27, Sess Hist Top IO Query	2	[{"changed": {"fields": ["task_sqlquery"]}}]	15	1
141	2018-11-12 21:08:10.869+05:30	28	28, Hist Top Obj Wait	2	[{"changed": {"fields": ["task_sqlquery"]}}]	15	1
142	2018-11-12 21:10:08.238+05:30	29	29, Sess Hist Top CPU Usage Query	2	[{"changed": {"fields": ["task_sqlquery"]}}]	15	1
143	2018-11-12 21:13:34.475+05:30	30	30, Session History(with wait time)	2	[{"changed": {"fields": ["task_sqlquery"]}}]	15	1
144	2018-11-12 21:16:31.396+05:30	41	41, show_sess_ops_usr_hist2	2	[{"changed": {"fields": ["task_name", "task_summary", "task_sqlquery"]}}]	15	1
145	2018-11-12 21:19:49.492+05:30	42	42, Verify Recent Table/Column Struct Change	2	[{"changed": {"fields": ["task_sqlquery"]}}]	15	1
146	2018-11-12 21:22:32.408+05:30	43	43, Identify/Pin Good SQL Plan	2	[{"changed": {"fields": ["task_sqlquery"]}}]	15	1
147	2018-11-12 21:30:11.425+05:30	31	31, Kill Session/Purge Plan(sid)	2	[{"changed": {"fields": ["task_sqlquery"]}}]	15	1
148	2018-11-12 21:35:19.699+05:30	32	32, sql plan stats for sql_id from awr	2	[{"changed": {"fields": ["task_sqlquery"]}}]	15	1
149	2018-11-12 21:55:16.335+05:30	33	33, All Query Plan Change Daily report(days)	2	[{"changed": {"fields": ["task_sqlquery"]}}]	15	1
150	2018-11-12 21:58:51.651+05:30	33	33, All Query Plan Change Daily report(days)	2	[]	15	1
151	2018-11-12 22:02:46.825+05:30	34	34, Wait class,event,sql_id between snap	2	[{"changed": {"fields": ["task_sqlquery"]}}]	15	1
152	2018-11-12 22:05:57.506+05:30	35	35, ASH report generation details(SID)	2	[{"changed": {"fields": ["task_sqlquery"]}}]	15	1
153	2018-11-13 08:05:18.003+05:30	36	36, Latch Wait event Check	2	[{"changed": {"fields": ["task_sqlquery"]}}]	15	1
154	2018-11-13 08:06:40.624+05:30	36	36, Latch Wait event Check	2	[{"changed": {"fields": ["task_sqlquery"]}}]	15	1
155	2018-11-13 08:09:53.468+05:30	37	37, Stale Stats for sql_id	2	[{"changed": {"fields": ["task_sqlquery"]}}]	15	1
156	2018-11-13 08:15:05.698+05:30	38	38, Long Open(Active/Inactive) Transaction	2	[{"changed": {"fields": ["task_sqlquery"]}}]	15	1
157	2018-11-13 08:20:54.844+05:30	40	40, Users last 30 min Session History	2	[{"changed": {"fields": ["task_sqlquery"]}}]	15	1
158	2018-11-13 08:29:06.464+05:30	45	45, AWR -Single/Comparison Report	2	[{"changed": {"fields": ["task_sqlquery"]}}]	15	1
159	2018-11-13 08:33:17.417+05:30	47	47, awr for comparision for multisnap	1	[{"added": {}}]	15	1
160	2018-11-13 08:39:56.96+05:30	46	46, current sql query monitor details	2	[{"changed": {"fields": ["task_sqlquery"]}}]	15	1
161	2018-11-22 11:06:49.231+05:30	7	207, Session detail(SID)	2	[{"changed": {"fields": ["task_number"]}}]	15	1
162	2018-11-22 11:07:34.899+05:30	2	302, SQL CurrPlan(sql_id)	2	[{"changed": {"fields": ["task_number"]}}]	15	1
163	2018-11-22 11:07:50.709+05:30	3	403, Long Query(sql_id)	2	[{"changed": {"fields": ["task_number"]}}]	15	1
164	2018-11-22 11:08:03.439+05:30	5	505, SQL Advisor(sql_id)	2	[{"changed": {"fields": ["task_number"]}}]	15	1
165	2018-11-22 11:08:17.69+05:30	6	606, SQL Text(sql_id)	2	[{"changed": {"fields": ["task_number"]}}]	15	1
166	2018-11-22 11:09:15.819+05:30	37	7037, Stale Stats for sql_id	2	[{"changed": {"fields": ["task_number"]}}]	15	1
167	2018-11-22 11:09:45.27+05:30	31	8031, Kill Session/Purge Plan(sid)	2	[{"changed": {"fields": ["task_number"]}}]	15	1
168	2018-11-22 11:10:05.383+05:30	35	9035, ASH report generation details(SID)	2	[{"changed": {"fields": ["task_number"]}}]	15	1
169	2018-11-22 11:10:31.842+05:30	32	10032, sql plan stats for sql_id from awr	2	[{"changed": {"fields": ["task_number"]}}]	15	1
170	2018-11-22 11:10:56.098+05:30	33	11033, All Query Plan Change Daily report(days)	2	[{"changed": {"fields": ["task_number"]}}]	15	1
171	2018-11-22 11:11:24.668+05:30	19	12019, Table,Index details	2	[{"changed": {"fields": ["task_number"]}}]	15	1
172	2018-11-22 11:11:47.525+05:30	8	1308, System wait event	2	[{"changed": {"fields": ["task_number"]}}]	15	1
173	2018-11-22 11:12:07.495+05:30	9	1409, High-CPU Sessions	2	[{"changed": {"fields": ["task_number"]}}]	15	1
174	2018-11-22 11:12:31.288+05:30	13	15013, Show All Blocking if exist	2	[{"changed": {"fields": ["task_number"]}}]	15	1
175	2018-11-22 11:12:50.294+05:30	36	16036, Latch Wait event Check	2	[{"changed": {"fields": ["task_number"]}}]	15	1
176	2018-11-22 11:13:06.878+05:30	27	17027, Sess Hist Top IO Query	2	[{"changed": {"fields": ["task_number"]}}]	15	1
177	2018-11-22 11:13:37.283+05:30	29	18029, Sess Hist Top CPU Usage Query	2	[{"changed": {"fields": ["task_number"]}}]	15	1
178	2018-11-22 11:14:05.459+05:30	28	19028, Hist Top Obj Wait	2	[{"changed": {"fields": ["task_number"]}}]	15	1
179	2018-11-22 11:14:28.185+05:30	14	20014, Show All History session details	2	[{"changed": {"fields": ["task_number"]}}]	15	1
180	2018-11-22 11:15:22.702+05:30	30	21030, Session History(with wait time)	2	[{"changed": {"fields": ["task_number"]}}]	15	1
181	2018-11-22 11:15:47.269+05:30	21	22021, show_sess_ops_usr_hist	2	[{"changed": {"fields": ["task_number"]}}]	15	1
182	2018-11-22 11:16:05.488+05:30	41	23041, show_sess_ops_usr_hist2	2	[{"changed": {"fields": ["task_number"]}}]	15	1
183	2018-11-22 11:16:25.856+05:30	24	24024, ADDM report(Between date)	2	[{"changed": {"fields": ["task_number"]}}]	15	1
184	2018-11-22 11:16:48.34+05:30	45	25045, AWR -Single/Comparison Report	2	[{"changed": {"fields": ["task_number"]}}]	15	1
185	2018-11-22 11:17:11.769+05:30	47	26047, awr for comparision for multisnap	2	[{"changed": {"fields": ["task_number"]}}]	15	1
186	2018-11-22 11:17:33.661+05:30	34	27034, Wait class,event,sql_id between snap	2	[{"changed": {"fields": ["task_number"]}}]	15	1
187	2018-11-22 11:18:03.083+05:30	39	28039, Interactive Sql Monitor	2	[{"changed": {"fields": ["task_number"]}}]	15	1
188	2018-11-22 11:19:07.854+05:30	1	101, Get Session(SID/Username/OS-User/Module)	2	[{"changed": {"fields": ["task_number"]}}]	15	1
189	2018-11-22 11:19:55.959+05:30	10	29010, Active Sessions	2	[{"changed": {"fields": ["task_number"]}}]	15	1
190	2018-11-22 11:20:18.385+05:30	11	30011, DML-Active Session	2	[{"changed": {"fields": ["task_number"]}}]	15	1
191	2018-11-22 11:20:46.826+05:30	38	32038, Long Open(Active/Inactive) Transaction	2	[{"changed": {"fields": ["task_number"]}}]	15	1
192	2018-11-22 11:21:07.722+05:30	15	33015, Tablespace free space	2	[{"changed": {"fields": ["task_number"]}}]	15	1
193	2018-11-22 11:21:32.389+05:30	16	34016, Temp Tablespace space	2	[{"changed": {"fields": ["task_number"]}}]	15	1
194	2018-11-22 11:21:54.117+05:30	17	35017, Undo space	2	[{"changed": {"fields": ["task_number"]}}]	15	1
195	2018-11-22 11:22:19.828+05:30	22	36022, ASM DiskGroup Details	2	[{"changed": {"fields": ["task_number"]}}]	15	1
196	2018-11-22 11:22:42.974+05:30	23	37023, ASM Disk Performance	2	[{"changed": {"fields": ["task_number"]}}]	15	1
197	2018-11-22 11:23:10.647+05:30	18	38018, RMAN Backup	2	[{"changed": {"fields": ["task_number"]}}]	15	1
198	2018-11-22 11:23:28.257+05:30	20	39020, DB Service Status	2	[{"changed": {"fields": ["task_number"]}}]	15	1
199	2018-11-22 11:23:48.432+05:30	25	40025, Archive Gap	2	[{"changed": {"fields": ["task_number"]}}]	15	1
200	2018-11-22 11:24:09.127+05:30	26	41026, Alert log contents	2	[{"changed": {"fields": ["task_number"]}}]	15	1
201	2018-11-22 11:25:44.794+05:30	44	42044, View History Log Files	2	[{"changed": {"fields": ["task_number"]}}]	15	1
202	2018-11-22 11:26:05.884+05:30	40	43040, Users last 30 min Session History	2	[{"changed": {"fields": ["task_number"]}}]	15	1
203	2018-11-22 11:26:20.241+05:30	4	4404, SQl Plan(sql_id)	2	[{"changed": {"fields": ["task_number"]}}]	15	1
204	2018-11-22 11:26:39.715+05:30	43	45043, Identify/Pin Good SQL Plan	2	[{"changed": {"fields": ["task_number"]}}]	15	1
205	2018-11-22 11:27:03.224+05:30	46	46046, current sql query monitor details	2	[{"changed": {"fields": ["task_number"]}}]	15	1
206	2018-11-22 11:27:33.597+05:30	42	47042, Verify Recent Table/Column Struct Change	2	[{"changed": {"fields": ["task_number"]}}]	15	1
207	2018-11-22 11:27:57.234+05:30	12	31012, All Session(Active+Inactive+Sys)	2	[{"changed": {"fields": ["task_number"]}}]	15	1
208	2018-11-22 11:28:52.589+05:30	1	1, Get Session(SID/Username/OS-User/Module)	2	[{"changed": {"fields": ["task_number"]}}]	15	1
209	2018-11-22 11:29:02.517+05:30	1	1, Get Session(SID/Username/OS-User/Module)	2	[]	15	1
210	2018-11-22 11:29:18.185+05:30	7	2, Session detail(SID)	2	[{"changed": {"fields": ["task_number"]}}]	15	1
211	2018-11-22 11:29:26.477+05:30	2	3, SQL CurrPlan(sql_id)	2	[{"changed": {"fields": ["task_number"]}}]	15	1
212	2018-11-22 11:29:34.534+05:30	3	4, Long Query(sql_id)	2	[{"changed": {"fields": ["task_number"]}}]	15	1
213	2018-11-22 11:29:43.384+05:30	5	5, SQL Advisor(sql_id)	2	[{"changed": {"fields": ["task_number"]}}]	15	1
214	2018-11-22 11:29:52.294+05:30	6	6, SQL Text(sql_id)	2	[{"changed": {"fields": ["task_number"]}}]	15	1
215	2018-11-22 11:30:16.505+05:30	8	13, System wait event	2	[{"changed": {"fields": ["task_number"]}}]	15	1
216	2018-11-22 11:30:28.372+05:30	9	14, High-CPU Sessions	2	[{"changed": {"fields": ["task_number"]}}]	15	1
217	2018-11-22 11:30:39.349+05:30	4	44, SQl Plan(sql_id)	2	[{"changed": {"fields": ["task_number"]}}]	15	1
218	2018-11-22 11:30:52.654+05:30	37	7, Stale Stats for sql_id	2	[{"changed": {"fields": ["task_number"]}}]	15	1
219	2018-11-22 11:31:06.086+05:30	31	8, Kill Session/Purge Plan(sid)	2	[{"changed": {"fields": ["task_number"]}}]	15	1
220	2018-11-22 11:31:16.04+05:30	35	9, ASH report generation details(SID)	2	[{"changed": {"fields": ["task_number"]}}]	15	1
221	2018-11-22 11:31:30.441+05:30	32	10, sql plan stats for sql_id from awr	2	[{"changed": {"fields": ["task_number"]}}]	15	1
222	2018-11-22 11:31:42.934+05:30	33	11, All Query Plan Change Daily report(days)	2	[{"changed": {"fields": ["task_number"]}}]	15	1
223	2018-11-22 11:31:55.406+05:30	19	12, Table,Index details	2	[{"changed": {"fields": ["task_number"]}}]	15	1
224	2018-11-22 11:32:08.528+05:30	13	15, Show All Blocking if exist	2	[{"changed": {"fields": ["task_number"]}}]	15	1
225	2018-11-22 11:32:22.801+05:30	36	16, Latch Wait event Check	2	[{"changed": {"fields": ["task_number"]}}]	15	1
226	2018-11-22 11:32:36.539+05:30	27	17, Sess Hist Top IO Query	2	[{"changed": {"fields": ["task_number"]}}]	15	1
227	2018-11-22 11:32:52.972+05:30	29	18, Sess Hist Top CPU Usage Query	2	[{"changed": {"fields": ["task_number"]}}]	15	1
228	2018-11-22 11:33:12.403+05:30	28	19, Hist Top Obj Wait	2	[{"changed": {"fields": ["task_number"]}}]	15	1
229	2018-11-22 11:33:25.328+05:30	14	20, Show All History session details	2	[{"changed": {"fields": ["task_number"]}}]	15	1
230	2018-11-22 11:33:39.622+05:30	30	21, Session History(with wait time)	2	[{"changed": {"fields": ["task_number"]}}]	15	1
231	2018-11-22 11:33:51.742+05:30	21	22, show_sess_ops_usr_hist	2	[{"changed": {"fields": ["task_number"]}}]	15	1
232	2018-11-22 11:34:09.407+05:30	41	23, show_sess_ops_usr_hist2	2	[{"changed": {"fields": ["task_number"]}}]	15	1
233	2018-11-22 11:34:23.762+05:30	24	24, ADDM report(Between date)	2	[{"changed": {"fields": ["task_number"]}}]	15	1
234	2018-11-22 11:34:43.421+05:30	45	25, AWR -Single/Comparison Report	2	[{"changed": {"fields": ["task_number"]}}]	15	1
235	2018-11-22 11:35:12.788+05:30	47	26, awr for comparision for multisnap	2	[{"changed": {"fields": ["task_number"]}}]	15	1
236	2018-11-22 11:35:28.765+05:30	34	27, Wait class,event,sql_id between snap	2	[{"changed": {"fields": ["task_number"]}}]	15	1
237	2018-11-22 11:35:40.297+05:30	39	28, Interactive Sql Monitor	2	[{"changed": {"fields": ["task_number"]}}]	15	1
238	2018-11-22 11:35:52.489+05:30	10	29, Active Sessions	2	[{"changed": {"fields": ["task_number"]}}]	15	1
239	2018-11-22 11:36:04.949+05:30	11	30, DML-Active Session	2	[{"changed": {"fields": ["task_number"]}}]	15	1
240	2018-11-22 11:36:15.804+05:30	12	31, All Session(Active+Inactive+Sys)	2	[{"changed": {"fields": ["task_number"]}}]	15	1
241	2018-11-22 11:36:26.444+05:30	38	32, Long Open(Active/Inactive) Transaction	2	[{"changed": {"fields": ["task_number"]}}]	15	1
242	2018-11-22 11:36:37.124+05:30	15	33, Tablespace free space	2	[{"changed": {"fields": ["task_number"]}}]	15	1
243	2018-11-22 11:36:50.71+05:30	16	34, Temp Tablespace space	2	[{"changed": {"fields": ["task_number"]}}]	15	1
244	2018-11-22 11:37:04.341+05:30	17	35, Undo space	2	[{"changed": {"fields": ["task_number"]}}]	15	1
245	2018-11-22 11:37:15.084+05:30	22	36, ASM DiskGroup Details	2	[{"changed": {"fields": ["task_number"]}}]	15	1
246	2018-11-22 11:37:26.308+05:30	23	37, ASM Disk Performance	2	[{"changed": {"fields": ["task_number"]}}]	15	1
247	2018-11-22 11:37:39.385+05:30	18	38, RMAN Backup	2	[{"changed": {"fields": ["task_number"]}}]	15	1
248	2018-11-22 11:37:50.072+05:30	20	39, DB Service Status	2	[{"changed": {"fields": ["task_number"]}}]	15	1
249	2018-11-22 11:38:02.754+05:30	25	40, Archive Gap	2	[{"changed": {"fields": ["task_number"]}}]	15	1
250	2018-11-22 11:38:13.316+05:30	26	41, Alert log contents	2	[{"changed": {"fields": ["task_number"]}}]	15	1
251	2018-11-22 11:38:27.78+05:30	44	42, View History Log Files	2	[{"changed": {"fields": ["task_number"]}}]	15	1
252	2018-11-22 11:38:40.237+05:30	40	43, Users last 30 min Session History	2	[{"changed": {"fields": ["task_number"]}}]	15	1
253	2018-11-22 11:38:54.032+05:30	43	45, Identify/Pin Good SQL Plan	2	[{"changed": {"fields": ["task_number"]}}]	15	1
254	2018-11-22 11:39:09.278+05:30	46	46, current sql query monitor details	2	[{"changed": {"fields": ["task_number"]}}]	15	1
255	2018-11-22 11:39:21.474+05:30	42	47, Verify Recent Table/Column Struct Change	2	[{"changed": {"fields": ["task_number"]}}]	15	1
256	2018-11-23 17:38:11.216+05:30	40	43, Users last 30 min Session History	3		15	1
257	2018-11-23 17:38:11.385+05:30	4	44, SQl Plan(sql_id)	3		15	1
259	2018-11-23 17:38:11.651+05:30	46	46, current sql query monitor details	3		15	1
260	2018-11-23 17:38:11.773+05:30	42	47, Verify Recent Table/Column Struct Change	3		15	1
261	2018-11-24 09:58:28.716+05:30	loadtest	Dbaloginuser object (loadtest)	2	[{"changed": {"fields": ["user_email"]}}]	14	1
262	2018-11-24 09:58:38.85+05:30	ketan	Dbaloginuser object (ketan)	2	[{"changed": {"fields": ["user_email"]}}]	14	1
263	2018-11-24 09:58:56.969+05:30	variakn	Dbaloginuser object (variakn)	3		14	1
264	2018-11-25 15:16:10.131+05:30	15	33, Tablespace free space	2	[{"changed": {"fields": ["task_sqlquery"]}}]	15	1
265	2018-11-25 15:38:30.948+05:30	19	12, Table,Index details	2	[{"changed": {"fields": ["task_sqlquery"]}}]	15	1
266	2018-11-25 15:50:32.72+05:30	19	12, Table,Index details	2	[{"changed": {"fields": ["task_sqlquery"]}}]	15	1
267	2018-11-25 15:52:34.862+05:30	19	12, Table,Index details	2	[{"changed": {"fields": ["task_sqlquery"]}}]	15	1
268	2018-11-25 16:17:13.256+05:30	30	21, Session History(blocked/wait time)	2	[{"changed": {"fields": ["task_name", "task_summary"]}}]	15	1
269	2018-11-25 16:40:54.974+05:30	14	20, Session History(blocked/wait time)	2	[{"changed": {"fields": ["task_name", "task_summary"]}}]	15	1
270	2018-11-25 16:51:45.356+05:30	30	21, Session History(All sessions)	2	[{"changed": {"fields": ["task_name", "task_summary"]}}]	15	1
271	2018-11-25 16:59:42.146+05:30	14	20, Session History(blocked/wait time)	2	[{"changed": {"fields": ["task_sqlquery"]}}]	15	1
272	2018-11-25 17:10:01.117+05:30	30	21, Session History(All sessions)	2	[{"changed": {"fields": ["task_sqlquery"]}}]	15	1
273	2018-11-25 17:50:20.03+05:30	41	23, show_sess_ops_usr_hist2	2	[{"changed": {"fields": ["task_sqlquery"]}}]	15	1
274	2018-11-25 18:00:08.494+05:30	41	23, show_sess_ops_usr_hist2	2	[{"changed": {"fields": ["task_sqlquery"]}}]	15	1
275	2018-11-25 18:20:06.506+05:30	21	22, show_sess_ops_usr_hist	2	[{"changed": {"fields": ["task_sqlquery"]}}]	15	1
276	2018-11-25 18:32:22.531+05:30	21	22, Query History execution details	2	[{"changed": {"fields": ["task_name", "task_summary"]}}]	15	1
277	2018-11-25 18:33:14.957+05:30	41	23, Query History execution details(pending)	2	[{"changed": {"fields": ["task_name", "task_summary"]}}]	15	1
278	2018-11-25 22:08:05.408+05:30	41	23, Query History execution details(pending)	2	[{"changed": {"fields": ["task_sqlquery"]}}]	15	1
279	2018-11-25 22:18:21.852+05:30	41	23, Query History execution details(pending)	2	[]	15	1
280	2018-11-25 22:26:08.532+05:30	41	23, Session History execution details	2	[{"changed": {"fields": ["task_name", "task_summary"]}}]	15	1
281	2018-11-25 22:39:47.013+05:30	30	21, Session History(All sessions)	2	[{"changed": {"fields": ["task_sqlquery"]}}]	15	1
282	2018-11-25 22:40:45.202+05:30	14	20, Session History(blocked/wait time)	2	[{"changed": {"fields": ["task_sqlquery"]}}]	15	1
283	2018-11-25 22:45:20.974+05:30	21	22, Query specific history execution	2	[{"changed": {"fields": ["task_name", "task_summary", "task_sqlquery"]}}]	15	1
284	2018-11-25 22:59:25.239+05:30	21	22, Query specific history execution	2	[{"changed": {"fields": ["task_sqlquery"]}}]	15	1
285	2018-11-25 23:02:04.725+05:30	21	22, session history include execution details	2	[{"changed": {"fields": ["task_name", "task_summary"]}}]	15	1
286	2018-11-25 23:03:38.412+05:30	41	23, Query specific history sessions	2	[{"changed": {"fields": ["task_name", "task_summary", "task_sqlquery"]}}]	15	1
287	2018-11-25 23:09:42.653+05:30	41	23, Query specific history sessions	2	[{"changed": {"fields": ["task_sqlquery"]}}]	15	1
288	2018-11-25 23:24:41.227+05:30	30	21, Session History(All sessions)	2	[{"changed": {"fields": ["task_sqlquery"]}}]	15	1
289	2018-11-26 07:55:32.658+05:30	16	54, Temp Tablespace space	2	[{"changed": {"fields": ["task_number"]}}]	15	1
290	2018-11-26 08:05:18.711+05:30	45	34, AWR -Single/Comparison Report	2	[{"changed": {"fields": ["task_number"]}}]	15	1
291	2018-11-26 08:17:57.958+05:30	45	34, Wait class,event,sql_id between snap	2	[{"changed": {"fields": ["task_name", "task_summary", "task_sqlquery"]}}]	15	1
292	2018-11-26 08:24:11.281+05:30	47	44, awr for comparision for multisnap	2	[{"changed": {"fields": ["task_number"]}}]	15	1
293	2018-11-26 08:54:18.913+05:30	34	27, option pending	2	[{"changed": {"fields": ["task_name", "task_summary", "task_sqlquery"]}}]	15	1
294	2018-11-26 09:03:56.617+05:30	39	99, Interactive Sql Monitor	2	[{"changed": {"fields": ["task_number"]}}]	15	1
295	2018-11-26 17:53:18.741+05:30	34	27, awr report for single/multi snap comparison	2	[{"changed": {"fields": ["task_name", "task_summary", "task_sqlquery"]}}]	15	1
296	2018-11-26 18:08:33.831+05:30	25	25, Archive Gap	2	[{"changed": {"fields": ["task_number"]}}]	15	1
297	2018-11-26 18:08:56.549+05:30	26	26, Alert log contents	2	[{"changed": {"fields": ["task_number"]}}]	15	1
298	2018-11-26 18:21:27.189+05:30	48	28, Yet to add(pending)	1	[{"added": {}}]	15	1
299	2018-12-06 10:21:21.95996+05:30	1	1, Current session(SID/Username/OS-User/Module)	2	[{"changed": {"fields": ["task_name"]}}]	15	1
300	2018-12-06 10:23:03.820936+05:30	2	3, SQL Current plan hash value(sql_id)	2	[{"changed": {"fields": ["task_name"]}}]	15	1
301	2018-12-06 10:23:30.439573+05:30	3	4, Long query(sql_id)	2	[{"changed": {"fields": ["task_name"]}}]	15	1
302	2018-12-06 10:24:01.79699+05:30	6	6, SQL text(sql_id)	2	[{"changed": {"fields": ["task_name"]}}]	15	1
303	2018-12-06 10:24:43.648719+05:30	31	8, Kill Session/Purge Plan Syntax (sid)	2	[{"changed": {"fields": ["task_name"]}}]	15	1
304	2018-12-06 10:25:28.519389+05:30	35	9, ASH report (SID)	2	[{"changed": {"fields": ["task_name"]}}]	15	1
305	2018-12-06 10:25:37.757242+05:30	35	9, ASH report (SID)	2	[]	15	1
306	2018-12-06 10:27:25.792801+05:30	32	10, Sql plan stats for sql_id from awr	2	[{"changed": {"fields": ["task_name"]}}]	15	1
307	2018-12-06 10:27:53.800764+05:30	33	11, Query Plan Change Daily report(days)	2	[{"changed": {"fields": ["task_name"]}}]	15	1
308	2018-12-06 10:28:38.74982+05:30	19	12, Table,Index analyze details	2	[{"changed": {"fields": ["task_name"]}}]	15	1
309	2018-12-06 10:29:55.590807+05:30	19	12, Table,Index stats detail	2	[{"changed": {"fields": ["task_name"]}}]	15	1
310	2018-12-06 10:30:53.907632+05:30	13	15, Blocking  sessions	2	[{"changed": {"fields": ["task_name"]}}]	15	1
311	2018-12-06 10:31:16.092796+05:30	36	16, Latch Wait event	2	[{"changed": {"fields": ["task_name"]}}]	15	1
312	2018-12-06 10:31:50.601149+05:30	28	19, Sess Hist Top Obj Wait	2	[{"changed": {"fields": ["task_name"]}}]	15	1
313	2018-12-06 10:32:35.115786+05:30	28	19, Session Hist Top Obj Wait	2	[{"changed": {"fields": ["task_name"]}}]	15	1
314	2018-12-06 10:33:01.406384+05:30	29	18, Session Hist Top CPU Usage Query	2	[{"changed": {"fields": ["task_name"]}}]	15	1
315	2018-12-06 10:34:00.566215+05:30	27	17, Session Hist Top IO Query	2	[{"changed": {"fields": ["task_name"]}}]	15	1
316	2018-12-06 10:34:41.735562+05:30	21	22, Session history include execution details	2	[{"changed": {"fields": ["task_name"]}}]	15	1
317	2018-12-06 10:35:06.422892+05:30	34	27, Awr report for single/multi snap comparison	2	[{"changed": {"fields": ["task_name"]}}]	15	1
318	2018-12-06 10:40:52.976772+05:30	20	39, Database Service Status	2	[{"changed": {"fields": ["task_name"]}}]	15	1
319	2018-12-06 10:41:43.021842+05:30	34	27, Awr report for single/multi snap comparison	2	[]	15	1
320	2018-12-06 10:42:18.160515+05:30	10	29, Active All Sessions	2	[{"changed": {"fields": ["task_name"]}}]	15	1
321	2018-12-06 10:42:52.887331+05:30	47	44, Awr for comparison for multi snap	2	[{"changed": {"fields": ["task_name"]}}]	15	1
322	2018-12-06 10:43:36.846457+05:30	11	30, Active DML Session	2	[{"changed": {"fields": ["task_name"]}}]	15	1
323	2018-12-06 10:45:19.89731+05:30	48	28, Yet to add(pending)	3		15	1
324	2018-12-06 10:45:35.089076+05:30	16	28, Temp Tablespace space	2	[{"changed": {"fields": ["task_number"]}}]	15	1
325	2018-12-06 13:10:32.508463+05:30	44	View History Log Files	2	[{"changed": {"fields": ["task_number"]}}]	15	1
326	2018-12-06 13:34:19.971866+05:30	47	44, Awr for comparison for multi snap	3		15	1
327	2018-12-06 18:00:44.278074+05:30	18	38, RMAN Backup	2	[{"changed": {"fields": ["task_sqlquery"]}}]	15	1
328	2018-12-06 18:03:37.220751+05:30	18	38, RMAN Backup	2	[{"changed": {"fields": ["task_sqlquery"]}}]	15	1
329	2018-12-07 06:45:08.045559+05:30	35	9, ASH report (SID)	2	[{"changed": {"fields": ["task_sqlquery"]}}]	15	1
330	2018-12-07 06:45:23.304697+05:30	32	10, Sql plan stats for sql_id from awr	2	[{"changed": {"fields": ["task_sqlquery"]}}]	15	1
331	2018-12-07 06:45:54.801318+05:30	45	34, Wait class,event,sql_id between snap	2	[{"changed": {"fields": ["task_sqlquery"]}}]	15	1
332	2018-12-07 06:46:11.963978+05:30	44	40, View History Log Files	2	[{"changed": {"fields": ["task_sqlquery"]}}]	15	1
333	2018-12-07 06:46:27.586401+05:30	39	99, Interactive Sql Monitor	2	[{"changed": {"fields": ["task_sqlquery"]}}]	15	1
\.


--
-- Data for Name: django_content_type; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.django_content_type (id, app_label, model) FROM stdin;
1	admin	logentry
2	auth	permission
3	auth	group
4	auth	user
5	contenttypes	contenttype
6	sessions	session
7	catalog	author
8	catalog	book
9	catalog	bookinstance
10	catalog	genre
11	catalog	language
12	catalog	dbamenu
13	catalog	dbaloginuser
14	dbawebmenu	dbaloginuser
15	dbawebmenu	dbamenu
\.


--
-- Data for Name: django_migrations; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.django_migrations (id, app, name, applied) FROM stdin;
1	contenttypes	0001_initial	2018-12-03 06:28:13.381867+05:30
2	auth	0001_initial	2018-12-03 06:28:14.613036+05:30
3	admin	0001_initial	2018-12-03 06:28:14.876579+05:30
4	admin	0002_logentry_remove_auto_add	2018-12-03 06:28:14.908194+05:30
5	contenttypes	0002_remove_content_type_name	2018-12-03 06:28:14.972096+05:30
6	auth	0002_alter_permission_name_max_length	2018-12-03 06:28:14.981084+05:30
7	auth	0003_alter_user_email_max_length	2018-12-03 06:28:14.994094+05:30
8	auth	0004_alter_user_username_opts	2018-12-03 06:28:15.003118+05:30
9	auth	0005_alter_user_last_login_null	2018-12-03 06:28:15.014127+05:30
10	auth	0006_require_contenttypes_0002	2018-12-03 06:28:15.01611+05:30
11	auth	0007_alter_validators_add_error_messages	2018-12-03 06:28:15.030143+05:30
12	auth	0008_alter_user_username_max_length	2018-12-03 06:28:15.158067+05:30
13	auth	0009_alter_user_last_name_max_length	2018-12-03 06:28:15.173692+05:30
14	dbawebmenu	0001_initial	2018-12-03 06:28:15.40722+05:30
15	dbawebmenu	0002_dbamenu_task_sqlquery	2018-12-03 06:28:15.415226+05:30
16	sessions	0001_initial	2018-12-03 06:28:15.592048+05:30
17	dbawebmenu	0003_auto_20181207_0707	2018-12-07 07:07:33.477221+05:30
\.


--
-- Data for Name: django_session; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.django_session (session_key, session_data, expire_date) FROM stdin;
46xm00gjtlevbvsm7uqgjegizyetu770	NWRlMmJhYzhkZGEyNTYwMDZkN2MwYTZkODYwM2I5ODQ5OGQyYzA5ZTp7Im51bV92aXNpdHMiOjEsIl9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI3OTc4YTkxYWZlNmI5MzdjNjAxNGNkMzg1N2YxYTE0MmM5NzM4M2MyIn0=	2018-11-28 10:20:47.165+05:30
ipm6tban9w036xor47cpxxusu7dz94rs	MGE4ZDA2NDE4N2FkZDIxNDFiZWY1M2IxMzAyZDViZTNjYWE5Njc1Zjp7Im51bV92aXNpdHMiOjF9	2018-09-07 09:08:01.042+05:30
k0qpnnxjoquyw3qmfcfmjwltevtu8pao	YjZiMDFlZDM2ZDVlNzY5OTAyY2FkYTlkMjY3NzVhMDVlZjZlZDE3ZTp7Im51bV92aXNpdHMiOjJ9	2018-11-23 16:41:14.584+05:30
kemgegrc1a7jd1eaz9pjhfjhh9l92lqe	ZjY1MmYzMGFlMmZhZjM0Y2VmNDdkNDkyMDNiYzhkNjMwMDJjNWE0MDp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiIzMmQ1ZDEwNzZmYmFkODViYWFjNTkwZWNhMmJmNTllYWYyMTA1NjIzIiwibnVtX3Zpc2l0cyI6MTI4fQ==	2018-10-13 12:28:57.234+05:30
nj09iw0l986esmll13v43xkoi5kvokjs	MGE4ZDA2NDE4N2FkZDIxNDFiZWY1M2IxMzAyZDViZTNjYWE5Njc1Zjp7Im51bV92aXNpdHMiOjF9	2018-10-04 21:03:23.737+05:30
nsdiyrw4zsegd0h1mrlb0sxlmk74fc4y	NWY2NWQ1NzllZWVhZGIyYmU0NDM5OTZkZGZlNWNhNjhjMDAxZmE1Yzp7Im51bV92aXNpdHMiOjE0LCJfYXV0aF91c2VyX2lkIjoiMSIsIl9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9oYXNoIjoiZDBmZjUyMWFmNDc0YWE2NWY1YzFkZThmNGRlZGNkNjI2MjQ3ZGYyNCJ9	2018-11-24 10:09:58.303+05:30
od5f8ig5sqsw812bz4yt9dkmjhnr2rlf	Y2JkNTc4M2M2OTIwZWI0NTI3NzhjOTUyYzI2ZTNjYWRkNWQ3MjIzMTp7Im51bV92aXNpdHMiOjJ9	2018-11-20 09:07:33.633+05:30
p2f93u2gkexwtk0z3oxizn0g1kiykc1r	ZTkzYmU5ODQxYTVlODBkYTg5ZGNlOTNhMzY5YjAwODhjOTFkNmY3ZDp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI3OTc4YTkxYWZlNmI5MzdjNjAxNGNkMzg1N2YxYTE0MmM5NzM4M2MyIiwibnVtX3Zpc2l0cyI6NDh9	2018-12-15 09:44:37.2+05:30
p9p2i1cla8yp2a4xvi9c7ore9fim1c6r	OTRlNjM2ZmM4NzkyMTg0OTlhMzkzOTYyMzc3ZWNlZDk5NjgzZDdmZTp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiIzMmQ1ZDEwNzZmYmFkODViYWFjNTkwZWNhMmJmNTllYWYyMTA1NjIzIiwibnVtX3Zpc2l0cyI6Mjh9	2018-09-06 20:22:58.991+05:30
typbv8231hrpa80ryak4kyusql2t2wtv	MjYzMGE2MmJlZDg3Mzg2MTRlYjUzOGNiZmUwNjAzNzY2YzY4NjdlMzp7Im51bV92aXNpdHMiOjUsIl9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI5NmU0ZDYzN2FiZDQ0OTU2NWI1MGQzYWIwOTBhZWNmZGUxZDcwNzhhIn0=	2018-10-14 10:32:20.245+05:30
y7a1086m4lfano79a8z34scxv3gyflw8	MWIwODAyNWMzMzE0YWU3NWQ0NGRmZjdiODFlNWVjZWRiODc0MDU2Nzp7Im51bV92aXNpdHMiOjQ2LCJfYXV0aF91c2VyX2lkIjoiMSIsIl9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9oYXNoIjoiZDBmZjUyMWFmNDc0YWE2NWY1YzFkZThmNGRlZGNkNjI2MjQ3ZGYyNCJ9	2018-11-27 08:00:44.053+05:30
azyew7hqmtgfjbhmlozvwmmsod9j00ag	ODc0MTMxOWM5NmIzMjhkN2JlZDY1OGM2ODIxM2U3MDVjZDBmNjg2MTp7Im51bV92aXNpdHMiOjF9	2018-12-17 08:33:01.427491+05:30
st1gkpdgejnlxjjqbn2pzkphm560yy5q	NGEzM2M0NWJmZjU4YTU4OTc0NmNkZmJmOTUyODRhNGYyYzY2Yjk5Yjp7Im51bV92aXNpdHMiOjE1MSwiX2F1dGhfdXNlcl9pZCI6IjEiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZCIsIl9hdXRoX3VzZXJfaGFzaCI6Ijc5NzhhOTFhZmU2YjkzN2M2MDE0Y2QzODU3ZjFhMTQyYzk3MzgzYzIifQ==	2018-12-21 07:08:00.563004+05:30
\.


--
-- Name: auth_group_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.auth_group_id_seq', 1, false);


--
-- Name: auth_group_permissions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.auth_group_permissions_id_seq', 1, false);


--
-- Name: auth_permission_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.auth_permission_id_seq', 57, true);


--
-- Name: auth_user_groups_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.auth_user_groups_id_seq', 1, false);


--
-- Name: auth_user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.auth_user_id_seq', 2, true);


--
-- Name: auth_user_user_permissions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.auth_user_user_permissions_id_seq', 3, true);


--
-- Name: django_admin_log_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.django_admin_log_id_seq', 333, true);


--
-- Name: django_content_type_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.django_content_type_id_seq', 15, true);


--
-- Name: django_migrations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.django_migrations_id_seq', 17, true);


--
-- Name: auth_group auth_group_name_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.auth_group
    ADD CONSTRAINT auth_group_name_key UNIQUE (name);


--
-- Name: auth_group_permissions auth_group_permissions_group_id_permission_id_0cd325b0_uniq; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_group_id_permission_id_0cd325b0_uniq UNIQUE (group_id, permission_id);


--
-- Name: auth_group_permissions auth_group_permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_pkey PRIMARY KEY (id);


--
-- Name: auth_group auth_group_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.auth_group
    ADD CONSTRAINT auth_group_pkey PRIMARY KEY (id);


--
-- Name: auth_permission auth_permission_content_type_id_codename_01ab375a_uniq; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.auth_permission
    ADD CONSTRAINT auth_permission_content_type_id_codename_01ab375a_uniq UNIQUE (content_type_id, codename);


--
-- Name: auth_permission auth_permission_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.auth_permission
    ADD CONSTRAINT auth_permission_pkey PRIMARY KEY (id);


--
-- Name: auth_user_groups auth_user_groups_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.auth_user_groups
    ADD CONSTRAINT auth_user_groups_pkey PRIMARY KEY (id);


--
-- Name: auth_user_groups auth_user_groups_user_id_group_id_94350c0c_uniq; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.auth_user_groups
    ADD CONSTRAINT auth_user_groups_user_id_group_id_94350c0c_uniq UNIQUE (user_id, group_id);


--
-- Name: auth_user auth_user_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.auth_user
    ADD CONSTRAINT auth_user_pkey PRIMARY KEY (id);


--
-- Name: auth_user_user_permissions auth_user_user_permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.auth_user_user_permissions
    ADD CONSTRAINT auth_user_user_permissions_pkey PRIMARY KEY (id);


--
-- Name: auth_user_user_permissions auth_user_user_permissions_user_id_permission_id_14a6b632_uniq; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.auth_user_user_permissions
    ADD CONSTRAINT auth_user_user_permissions_user_id_permission_id_14a6b632_uniq UNIQUE (user_id, permission_id);


--
-- Name: auth_user auth_user_username_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.auth_user
    ADD CONSTRAINT auth_user_username_key UNIQUE (username);


--
-- Name: dbawebmenu_dbaloginuser dbawebmenu_dbaloginuser_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.dbawebmenu_dbaloginuser
    ADD CONSTRAINT dbawebmenu_dbaloginuser_pkey PRIMARY KEY (db_user_id);


--
-- Name: dbawebmenu_dbamenu dbawebmenu_dbamenu_task_number_e5297e9d_pk; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.dbawebmenu_dbamenu
    ADD CONSTRAINT dbawebmenu_dbamenu_task_number_e5297e9d_pk PRIMARY KEY (task_number);


--
-- Name: dbawebmenu_dbamenu dbawebmenu_dbamenu_task_number_e5297e9d_uniq; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.dbawebmenu_dbamenu
    ADD CONSTRAINT dbawebmenu_dbamenu_task_number_e5297e9d_uniq UNIQUE (task_number);


--
-- Name: django_admin_log django_admin_log_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.django_admin_log
    ADD CONSTRAINT django_admin_log_pkey PRIMARY KEY (id);


--
-- Name: django_content_type django_content_type_app_label_model_76bd3d3b_uniq; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.django_content_type
    ADD CONSTRAINT django_content_type_app_label_model_76bd3d3b_uniq UNIQUE (app_label, model);


--
-- Name: django_content_type django_content_type_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.django_content_type
    ADD CONSTRAINT django_content_type_pkey PRIMARY KEY (id);


--
-- Name: django_migrations django_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.django_migrations
    ADD CONSTRAINT django_migrations_pkey PRIMARY KEY (id);


--
-- Name: django_session django_session_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.django_session
    ADD CONSTRAINT django_session_pkey PRIMARY KEY (session_key);


--
-- Name: auth_group_name_a6ea08ec_like; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX auth_group_name_a6ea08ec_like ON public.auth_group USING btree (name varchar_pattern_ops);


--
-- Name: auth_group_permissions_group_id_b120cbf9; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX auth_group_permissions_group_id_b120cbf9 ON public.auth_group_permissions USING btree (group_id);


--
-- Name: auth_group_permissions_permission_id_84c5c92e; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX auth_group_permissions_permission_id_84c5c92e ON public.auth_group_permissions USING btree (permission_id);


--
-- Name: auth_permission_content_type_id_2f476e4b; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX auth_permission_content_type_id_2f476e4b ON public.auth_permission USING btree (content_type_id);


--
-- Name: auth_user_groups_group_id_97559544; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX auth_user_groups_group_id_97559544 ON public.auth_user_groups USING btree (group_id);


--
-- Name: auth_user_groups_user_id_6a12ed8b; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX auth_user_groups_user_id_6a12ed8b ON public.auth_user_groups USING btree (user_id);


--
-- Name: auth_user_user_permissions_permission_id_1fbb5f2c; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX auth_user_user_permissions_permission_id_1fbb5f2c ON public.auth_user_user_permissions USING btree (permission_id);


--
-- Name: auth_user_user_permissions_user_id_a95ead1b; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX auth_user_user_permissions_user_id_a95ead1b ON public.auth_user_user_permissions USING btree (user_id);


--
-- Name: auth_user_username_6821ab7c_like; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX auth_user_username_6821ab7c_like ON public.auth_user USING btree (username varchar_pattern_ops);


--
-- Name: dbawebmenu_dbaloginuser_db_user_id_66cb2c1b_like; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX dbawebmenu_dbaloginuser_db_user_id_66cb2c1b_like ON public.dbawebmenu_dbaloginuser USING btree (db_user_id varchar_pattern_ops);


--
-- Name: django_admin_log_content_type_id_c4bce8eb; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX django_admin_log_content_type_id_c4bce8eb ON public.django_admin_log USING btree (content_type_id);


--
-- Name: django_admin_log_user_id_c564eba6; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX django_admin_log_user_id_c564eba6 ON public.django_admin_log USING btree (user_id);


--
-- Name: django_session_expire_date_a5c62663; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX django_session_expire_date_a5c62663 ON public.django_session USING btree (expire_date);


--
-- Name: django_session_session_key_c0390e0f_like; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX django_session_session_key_c0390e0f_like ON public.django_session USING btree (session_key varchar_pattern_ops);


--
-- Name: auth_group_permissions auth_group_permissio_permission_id_84c5c92e_fk_auth_perm; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissio_permission_id_84c5c92e_fk_auth_perm FOREIGN KEY (permission_id) REFERENCES public.auth_permission(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_group_permissions auth_group_permissions_group_id_b120cbf9_fk_auth_group_id; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_group_id_b120cbf9_fk_auth_group_id FOREIGN KEY (group_id) REFERENCES public.auth_group(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_permission auth_permission_content_type_id_2f476e4b_fk_django_co; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.auth_permission
    ADD CONSTRAINT auth_permission_content_type_id_2f476e4b_fk_django_co FOREIGN KEY (content_type_id) REFERENCES public.django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_user_groups auth_user_groups_group_id_97559544_fk_auth_group_id; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.auth_user_groups
    ADD CONSTRAINT auth_user_groups_group_id_97559544_fk_auth_group_id FOREIGN KEY (group_id) REFERENCES public.auth_group(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_user_groups auth_user_groups_user_id_6a12ed8b_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.auth_user_groups
    ADD CONSTRAINT auth_user_groups_user_id_6a12ed8b_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_user_user_permissions auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.auth_user_user_permissions
    ADD CONSTRAINT auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm FOREIGN KEY (permission_id) REFERENCES public.auth_permission(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_user_user_permissions auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.auth_user_user_permissions
    ADD CONSTRAINT auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: django_admin_log django_admin_log_content_type_id_c4bce8eb_fk_django_co; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.django_admin_log
    ADD CONSTRAINT django_admin_log_content_type_id_c4bce8eb_fk_django_co FOREIGN KEY (content_type_id) REFERENCES public.django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: django_admin_log django_admin_log_user_id_c564eba6_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.django_admin_log
    ADD CONSTRAINT django_admin_log_user_id_c564eba6_fk FOREIGN KEY (user_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- PostgreSQL database dump complete
--

