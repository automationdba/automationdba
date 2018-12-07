from django.shortcuts import render
from django.http import HttpResponse

from django.views import generic
from django.conf import settings 
#from .forms import LoginViewForm
from .forms import LoginViewForm, DbamenuInputForm


# import models here.
from .models import Dbamenu , Dbaloginuser

# dbamenu specific packages
import sys, os, time,datetime,logging,tempfile,subprocess,getpass,socket
from subprocess import Popen, PIPE
from sys import platform
from django_globals import globals

# Global Variable Initialize
global gusername,gpassword,gconnectdb

# Model default view 
class DbamenuListView(generic.ListView):
    """
    Generic class-based list view for a list of dbamenu.
    """
    model = Dbamenu
    paginate_by = 50 
    
class DbamenuDetailView(generic.DetailView):
    """
    Generic class-based detail view for an dbamenu.
    """
    model = Dbamenu

# View defination

def loginpage(request):
     
     return render(request,'loginview.html')

def index0(request):
    """
    View function for home page of site.
    """
    num_dbamenus=Dbamenu.objects.count()  # The 'all()' is implied by default.

    # Number of visits to this view, as counted in the session variable.
    num_visits=request.session.get('num_visits', 0)
    request.session['num_visits'] = num_visits+1
    
    # Render the HTML template index.html with the data in the context variable.
    return render(
        request,
        'index.html',
        context={'num_visits':num_visits,'num_dbamenus':num_dbamenus},
    )

def Dbamenuviewsample(request):
    if  "1" in request.GET:
        return render(request, settings.BASE_DIR + '/dbawebmenu/templates/dbawebmenu/sample_logfile\ora12c_xshowsessions_ops_usr_sample.html')
    elif  "2" in request.GET:
        return render(request, settings.BASE_DIR + '/dbawebmenu/templates/dbawebmenu/sample_logfile\ora12c_xsid_rac_sample.html')
    elif  "3" in request.GET:
        return render(request, settings.BASE_DIR + '/dbawebmenu/templates/dbawebmenu/sample_logfile\ora12c_xsql_id_details_sample.html')	
    elif  "4" in request.GET:
        return render(request, settings.BASE_DIR + '/dbawebmenu/templates/dbawebmenu/sample_logfile\ora12c_xlong_qry_tune_sample.html')
    elif  "5" in request.GET:
        return render(request, settings.BASE_DIR + '/dbawebmenu/templates/dbawebmenu/sample_logfile\ora12c_xsql_advisor_v1101_sample.html.txt', content_type="text")
    elif  "6" in request.GET:
        return render(request, settings.BASE_DIR + '/dbawebmenu/templates/dbawebmenu/sample_logfile\ora12c_xsql_full_text_sample.html')
    elif  "7" in request.GET:
        return render(request, settings.BASE_DIR + '/dbawebmenu/templates/dbawebmenu/sample_logfile\ora12c_xstale_stat_sqlid_sample.html')	
    elif  "8" in request.GET:
        return render(request, settings.BASE_DIR + '/dbawebmenu/templates/dbawebmenu/sample_logfile\ora12c_xsess_kill_sample.html')
    elif  "9" in request.GET:
        return render(request, settings.BASE_DIR + '/dbawebmenu/templates/dbawebmenu/sample_logfile\\ash_rpt_ora12c_new_ashrpti_sample.html')
    elif  "10" in request.GET:
        return render(request, settings.BASE_DIR + '/dbawebmenu/templates/dbawebmenu/sample_logfile\\awr_sql_ora12c_k_awrsqrpi_sample.html')
    elif  "11" in request.GET:
        return render(request, settings.BASE_DIR + '/dbawebmenu/templates/dbawebmenu/sample_logfile\ora12c_xplan_change_daily_report_sample.html')
    elif  "12" in request.GET:
        return render(request, settings.BASE_DIR + '/dbawebmenu/templates/dbawebmenu/sample_logfile\ora12c_xtable_stats_sample.html')
    elif  "13" in request.GET:
        return render(request, settings.BASE_DIR + '/dbawebmenu/templates/dbawebmenu/sample_logfile\ora12c_xsystemevent_sample.html')
    elif  "14" in request.GET:
        return render(request, settings.BASE_DIR + '/dbawebmenu/templates/dbawebmenu/sample_logfile\ora12c_xtop_cpu_sample.html')
    elif  "15" in request.GET:
        return render(request, settings.BASE_DIR + '/dbawebmenu/templates/dbawebmenu/sample_logfile\ora12c_xblockers_rac_sample.html')        
    elif  "16" in request.GET:
        return render(request, settings.BASE_DIR + '/dbawebmenu/templates/dbawebmenu/sample_logfile\ora12c_xlatch_wait_rac_sample.html')
    elif  "17" in request.GET:
        return render(request, settings.BASE_DIR + '/dbawebmenu/templates/dbawebmenu/sample_logfile\ora12c_xshow_hist_top_io_wait_sample.html')
    elif  "18" in request.GET:
        return render(request, settings.BASE_DIR + '/dbawebmenu/templates/dbawebmenu/sample_logfile\ora12c_xshow_hist_top_cpu_usage_sample.html')
    elif  "19" in request.GET:
        return render(request, settings.BASE_DIR + '/dbawebmenu/templates/dbawebmenu/sample_logfile\ora12c_xshow_hist_top_obj_wait_sample.html')
    elif  "20" in request.GET:
        return render(request, settings.BASE_DIR + '/dbawebmenu/templates/dbawebmenu/sample_logfile\ora12c_xshow_sess_hist_wait_blocked_sample.html')
    elif  "21" in request.GET:
        return render(request, settings.BASE_DIR + '/dbawebmenu/templates/dbawebmenu/sample_logfile\ora12c_xshow_sess_hist_wait_all_sample.html')
    elif  "22" in request.GET:
        return render(request, settings.BASE_DIR + '/dbawebmenu/templates/dbawebmenu/sample_logfile\ora12c_xshow_sess_hist_run_time_sample.html')
    elif  "23" in request.GET:
        return render(request, settings.BASE_DIR + '/dbawebmenu/templates/dbawebmenu/sample_logfile\ora12c_xshow_qry_sess_run_time_sample.html')  	
    elif  "24" in request.GET:
        return render(request, settings.BASE_DIR + '/dbawebmenu/templates/dbawebmenu/sample_logfile\ora12c_xqry_addm_all_sample.html')
    elif  "25" in request.GET:
        return render(request, settings.BASE_DIR + '/dbawebmenu/templates/dbawebmenu/sample_logfile\ora12c_xarch_log_hist_qry_sample.html')
    elif  "26" in request.GET:
        return render(request, settings.BASE_DIR + '/dbawebmenu/templates/dbawebmenu/sample_logfile\ora12c_xalert_qry_sample.html')	
    elif  "27" in request.GET:
        return render(request, settings.BASE_DIR + '/dbawebmenu/templates/dbawebmenu/sample_logfile\\awr_rpt_ora12c_awrrpti_sample.html')	
    elif  "28" in request.GET:
        return render(request, settings.BASE_DIR + '/dbawebmenu/templates/dbawebmenu/sample_logfile\ora12c_xsortspace_sample.html') 
    elif  "29" in request.GET:
        return render(request, settings.BASE_DIR + '/dbawebmenu/templates/dbawebmenu/sample_logfile\ora12c_xshowsessions_active_sample.html')
    elif  "30" in request.GET:
        return render(request, settings.BASE_DIR + '/dbawebmenu/templates/dbawebmenu/sample_logfile\ora12c_xrac_long_run_txn_sample.html')
    elif  "31" in request.GET:
        return render(request, settings.BASE_DIR + '/dbawebmenu/templates/dbawebmenu/sample_logfile\ora12c_xall_sess_db_sample.html')
    elif  "32" in request.GET:
        return render(request, settings.BASE_DIR + '/dbawebmenu/templates/dbawebmenu/sample_logfile\ora12c_xlong_open_trans_sample.html')
    elif  "33" in request.GET:
        return render(request, settings.BASE_DIR + '/dbawebmenu/templates/dbawebmenu/sample_logfile\ora12c_xtbs_free_autoextend_sample.html')
    elif  "34" in request.GET:
        return render(request, settings.BASE_DIR + '/dbawebmenu/templates/dbawebmenu/sample_logfile\ora12c_xtbs_free_autoextend_sample.html')
    elif  "35" in request.GET:
        return render(request, settings.BASE_DIR + '/dbawebmenu/templates/dbawebmenu/sample_logfile\ora12c_xundo_details_sample.html')
    elif  "36" in request.GET:
        return render(request, settings.BASE_DIR + '/dbawebmenu/templates/dbawebmenu/sample_logfile\ora12c_xasm_diskgroups_sample.html')
    elif  "37" in request.GET:
        return render(request, settings.BASE_DIR + '/dbawebmenu/templates/dbawebmenu/sample_logfile\ora12c_xasm_disks_perf_sample.html')
    elif  "38" in request.GET:
        return render(request, settings.BASE_DIR + '/dbawebmenu/templates/dbawebmenu/sample_logfile\ora12c_xrman_details_sample.html')
    elif  "39" in request.GET:
        return render(request, settings.BASE_DIR + '/dbawebmenu/templates/dbawebmenu/sample_logfile\ora12c_xdb_service_all_sample.html')
    elif  "40" in request.GET:
        return render(request, settings.BASE_DIR + '/dbawebmenu/templates/dbawebmenu/sample_logfile\\all_log_filename_dir.html')
    elif  "99" in request.GET:
        return render(request, settings.BASE_DIR + '/dbawebmenu/templates/dbawebmenu/sample_logfile\ora12c_xlong_qry_tune_sample.html')


def db_user_credentials(uname,dbtns):
     
    global gusername,gpassword
    #gpassword="loadtest123" 
    uname=gusername
    passwd=gpassword
    #uname="loadtest"
    #passwd="loadtest123"
    
    conn_string = "%s/%s@%s"% (uname,passwd,dbtns)
    return conn_string

def db_query_location_path(queryfile,username,db_tns):
    from django.conf import settings
    dbstring=db_user_credentials(username,db_tns)
    sql_file=queryfile
    
    SQL_FILE_PATH= settings.BASE_DIR + '/dbawebmenu/dbamenu/'
    LOG_FILE_PATH= settings.BASE_DIR + '/dbawebmenu/templates/dbawebmenu/logfile/'
   
   
    now = datetime.datetime.now() 
    NOW=now.strftime('%C%y%m%d-%H%M%S-%f')
    
    sqlfilename=sql_file+".sql"
    log_file=db_tns+"_"+sql_file+"_"+NOW
    logfilename=log_file+".html"
    SQLFILE_FULL_PATH=SQL_FILE_PATH+sqlfilename
    LOGFILE_FULL_PATH=LOG_FILE_PATH+logfilename

    return SQLFILE_FULL_PATH,LOGFILE_FULL_PATH,dbstring

# return full sql query path,log file path and db connection string
def db_query_location_path2(queryfile,sqldirpath,logdirpath,username,db_tns):
    dbstring=db_user_credentials(username,db_tns)
    sql_file=queryfile
    
    SQL_FILE_PATH= sqldirpath
    LOG_FILE_PATH= logdirpath   
   
    now = datetime.datetime.now() 
    NOW=now.strftime('%C%y%m%d-%H%M%S-%f')
    
    sqlfilename=sql_file+".sql"
    log_file=db_tns+"_"+sql_file+"_"+NOW
    logfilename=log_file+".html"
    SQLFILE_FULL_PATH=SQL_FILE_PATH+sqlfilename
    LOGFILE_FULL_PATH=LOG_FILE_PATH+logfilename

    return SQLFILE_FULL_PATH,LOGFILE_FULL_PATH,dbstring    

from os import listdir
from os.path import isfile, join

# view list of log files
def viewlogfilenames(request):
   from django.conf import settings 
   LOG_FILE_PATH= settings.BASE_DIR + '/dbawebmenu/templates/dbawebmenu/logfile/'
   
   mypath = LOGFILE_FULL_PATH
   logfile_dir_name=os.path.dirname(mypath)
   return render(
        request,
        'dbamenu_listlogfiles.html',
        context={'logfile_dir_name':logfile_dir_name,'onlylogfiles':onlylogfiles},
    )

# AWR report related views for getting awr snapid
def dbamenugetawrsnapid(request):
    global gusername
    username=gusername
    db_tns=request.GET["db_tns"]
    sql_file="hist_snap_id"
    dbstring=db_user_credentials(username,db_tns)
    (SQLFILE_FULL_PATH,LOGFILE_FULL_PATH,dbstring) = db_query_location_path(sql_file,username,db_tns)
    arglist = []
    arg1=request.GET["45_1_option"]
    arglist.append(arg1) 
    exec_db_qry_local_html_list(SQLFILE_FULL_PATH,LOGFILE_FULL_PATH,dbstring,arglist)
    return render(request,LOGFILE_FULL_PATH)

# Get instance details
def dbamenugetinst(request):
    global gusername
    username=gusername
     
    db_tns=request.GET["db_tns"]
    sql_file="inst_details"
    dbstring=db_user_credentials(username,db_tns)
    (SQLFILE_FULL_PATH,LOGFILE_FULL_PATH,dbstring) = db_query_location_path(sql_file,username,db_tns)
    arglist = []
    exec_db_qry_local_html_list(SQLFILE_FULL_PATH,LOGFILE_FULL_PATH,dbstring,arglist)
    return render(request,LOGFILE_FULL_PATH)

# Get snap details
def dbamenu34snapdetail(request):
    global gusername
    username=gusername
    db_tns=request.GET["db_tns"]
    sql_file="hist_snap_id_1"
    dbstring=db_user_credentials(username,db_tns)
    (SQLFILE_FULL_PATH,LOGFILE_FULL_PATH,dbstring) = db_query_location_path(sql_file,username,db_tns)
    arglist = []
    arg1=request.GET["34_1_option"]
    arglist.append(arg1) 
    exec_db_qry_local_html_list(SQLFILE_FULL_PATH,LOGFILE_FULL_PATH,dbstring,arglist)
    return render(request,LOGFILE_FULL_PATH)

# Get wait class details     
def dbamenu34waitclassdetail(request):
    global gusername
    username=gusername
    db_tns=request.GET["db_tns"]
    sql_file="1_wait_class"
    dbstring=db_user_credentials(username,db_tns)
    (SQLFILE_FULL_PATH,LOGFILE_FULL_PATH,dbstring) = db_query_location_path(sql_file,username,db_tns)
    arglist = []
    arg1=request.GET["34_1_option"]
    arg2=request.GET["34_2_option"]
    arg3=request.GET["34_3_option"]
    arglist.append(arg1)
    arglist.append(arg2)
    arglist.append(arg3) 
    exec_db_qry_local_html_list(SQLFILE_FULL_PATH,LOGFILE_FULL_PATH,dbstring,arglist)
    return render(request,LOGFILE_FULL_PATH)

# Get wait event details
def dbamenu34waiteventdetail(request):
    global gusername
    username=gusername
    db_tns=request.GET["db_tns"]
    sql_file="2_wait_class_events_q"
    dbstring=db_user_credentials(username,db_tns)
    (SQLFILE_FULL_PATH,LOGFILE_FULL_PATH,dbstring) = db_query_location_path(sql_file,username,db_tns)
    arglist = []
    arg1=request.GET["34_1_option"]
    arg2=request.GET["34_2_option"]
    arg3=request.GET["34_3_option"]
    arg4=request.GET["34_4_option"]
    arglist.append(arg1)
    arglist.append(arg2)
    arglist.append(arg3) 
    arglist.append(arg4)
    exec_db_qry_local_html_list(SQLFILE_FULL_PATH,LOGFILE_FULL_PATH,dbstring,arglist)
    return render(request,LOGFILE_FULL_PATH)

# Get wait event query details
def dbamenu34waiteventsqldetail(request):
    global gusername
    username=gusername
    db_tns=request.GET["db_tns"]
    sql_file="3_event_sql_id"
    dbstring=db_user_credentials(username,db_tns)
    (SQLFILE_FULL_PATH,LOGFILE_FULL_PATH,dbstring) = db_query_location_path(sql_file,username,db_tns)
    arglist = []
    arg1=request.GET["34_1_option"]
    arg2=request.GET["34_2_option"]
    arg3=request.GET["34_3_option"]
    arg4=request.GET["34_5_option"]
    arglist.append(arg1)
    arglist.append(arg2)
    arglist.append(arg3) 
    arglist.append(arg4)
    exec_db_qry_local_html_list(SQLFILE_FULL_PATH,LOGFILE_FULL_PATH,dbstring,arglist)
    return render(request,LOGFILE_FULL_PATH)

# Get query explain plan
def dbamenu34sqlplan(request):
    global gusername
    username=gusername 
    db_tns=request.GET["db_tns"]
    sql_file="4_sqltext"
    dbstring=db_user_credentials(username,db_tns)
    (SQLFILE_FULL_PATH,LOGFILE_FULL_PATH,dbstring) = db_query_location_path(sql_file,username,db_tns)
    arglist = []
    arg1=request.GET["34_6_option"]
    arglist.append(arg1)
    exec_db_qry_local_html_list(SQLFILE_FULL_PATH,LOGFILE_FULL_PATH,dbstring,arglist)
    return render(request,LOGFILE_FULL_PATH)

#from django.conf import settings
# dbamenu detail query related all the views executed from this view

def dbamenuviewreport(request):
    from django.conf import settings    
     
    global gusername
     
    try:
       username=gusername
    except: 
       message="username not exist"
       return HttpResponse("Invalid !! "+message)
        
    SQL_FILE_DIR=settings.BASE_DIR+"/dbawebmenu/dbamenu/"
    LOG_FILE_DIR=settings.BASE_DIR+"/dbawebmenu/templates/dbawebmenu/logfile/"

    db_tns=request.GET["db_tns"]
    if username=="":
       message="Inavalid Username "+username
       return HttpResponse("Invalid !! "+message)
    else:
       dbstring=db_user_credentials(username,db_tns)

    
    if  "1" in request.GET: 
            sql_file="xshowsessions_ops_usr"
            sql_file_path= SQL_FILE_DIR + sql_file +'.sql'
            try:
               os.remove(sql_file_path)
            except OSError:
               pass    
            
            f=open(sql_file_path,'w')
            print("set markup html on ",file=f)
            print("SET SQLBLANKLINES ON",file=f)
        
            for rec in Dbamenu.objects.filter(task_number=1).all():
                print(rec.task_sqlquery,file=f)
            f.close()
                       
            (SQLFILE_FULL_PATH,LOGFILE_FULL_PATH,dbstring) = db_query_location_path2(sql_file,SQL_FILE_DIR,LOG_FILE_DIR,username,db_tns)
            arglist = []
            arg1=request.GET["1_1_option"]
            arglist.append(arg1) 
            exec_db_qry_local_html_list(SQLFILE_FULL_PATH,LOGFILE_FULL_PATH,dbstring,arglist)
            try:
                os.remove(sql_file_path)
            except OSError:
                pass    
            
            return render(request,LOGFILE_FULL_PATH)

    elif "2" in request.GET:  
            sql_file="xsid_rac"
            sql_file_path= SQL_FILE_DIR + sql_file +'.sql'
            try:
               os.remove(sql_file_path)
            except OSError:
               pass    
            
            f=open(sql_file_path,'w')
            print("set markup html on ",file=f)
            print("SET SQLBLANKLINES ON",file=f)
        
            for rec in Dbamenu.objects.filter(task_number=2).all():
                print(rec.task_sqlquery,file=f)
            f.close()
                       
            (SQLFILE_FULL_PATH,LOGFILE_FULL_PATH,dbstring) = db_query_location_path2(sql_file,SQL_FILE_DIR,LOG_FILE_DIR,username,db_tns)
            arglist = []
            arg1=request.GET["2_1_option"]
            arg2=request.GET["2_2_option"]
            arglist.append(arg1)
            arglist.append(arg2) 
            exec_db_qry_local_html_list(SQLFILE_FULL_PATH,LOGFILE_FULL_PATH,dbstring,arglist)
            try:
                os.remove(sql_file_path)
            except OSError:
                pass    
            
            return render(request,LOGFILE_FULL_PATH)
			
    elif "3" in request.GET:
            sql_file="xsql_id_details"
            sql_file_path= SQL_FILE_DIR + sql_file +'.sql'
            try:
               os.remove(sql_file_path)
            except OSError:
               pass    
            
            f=open(sql_file_path,'w')
            print("set markup html on ",file=f)
            print("SET SQLBLANKLINES ON",file=f)
        
            for rec in Dbamenu.objects.filter(task_number=3).all():
                print(rec.task_sqlquery,file=f)
            f.close()
                       
            (SQLFILE_FULL_PATH,LOGFILE_FULL_PATH,dbstring) = db_query_location_path2(sql_file,SQL_FILE_DIR,LOG_FILE_DIR,username,db_tns)
            arglist = []
            arg1=request.GET["3_1_option"]
            arglist.append(arg1) 
            exec_db_qry_local_html_list(SQLFILE_FULL_PATH,LOGFILE_FULL_PATH,dbstring,arglist)
            try:
                os.remove(sql_file_path)
            except OSError:
                pass    
            
            return render(request,LOGFILE_FULL_PATH) 
            
    elif "4" in request.GET:  
            sql_file="xlong_qry_tune"
            sql_file_path= SQL_FILE_DIR + sql_file +'.sql'
            try:
               os.remove(sql_file_path)
            except OSError:
               pass    
            
            f=open(sql_file_path,'w')
            print("set markup html on ",file=f)
            print("SET SQLBLANKLINES ON",file=f)
        
            for rec in Dbamenu.objects.filter(task_number=4).all():
                print(rec.task_sqlquery,file=f)
            f.close()
                       
            (SQLFILE_FULL_PATH,LOGFILE_FULL_PATH,dbstring) = db_query_location_path2(sql_file,SQL_FILE_DIR,LOG_FILE_DIR,username,db_tns)
            arglist = []
            arg1=request.GET["4_1_option"]
            arglist.append(arg1) 
            exec_db_qry_local_html_list(SQLFILE_FULL_PATH,LOGFILE_FULL_PATH,dbstring,arglist)
            try:
                os.remove(sql_file_path)
            except OSError:
                pass    
            
            return render(request,LOGFILE_FULL_PATH)  

    elif "5" in request.GET:
            sql_file="xsql_advisor_v1101"
            sql_file_path= SQL_FILE_DIR + sql_file +'.sql'
            try:
               os.remove(sql_file_path)
            except OSError:
               pass    
            
            f=open(sql_file_path,'w')
            #print("set markup html on ",file=f)
            print("SET SQLBLANKLINES ON",file=f)
        
            for rec in Dbamenu.objects.filter(task_number=5).all():
                print(rec.task_sqlquery,file=f)
            f.close()
                       
            (SQLFILE_FULL_PATH,LOGFILE_FULL_PATH,dbstring) = db_query_location_path2(sql_file,SQL_FILE_DIR,LOG_FILE_DIR,username,db_tns)
            arglist = []
            arg1=request.GET["5_1_option"]
            arglist.append(arg1)
            LOGFILE_TEXT_PATH=LOGFILE_FULL_PATH+".txt" 
            arglist.append(LOGFILE_TEXT_PATH)
            exec_db_qry_local_html_list(SQLFILE_FULL_PATH,LOGFILE_FULL_PATH,dbstring,arglist)
            try:
                os.remove(sql_file_path)
            except OSError:
                pass    
            
            #return render(request,LOGFILE_FULL_PATH)    
            return render(request,LOGFILE_TEXT_PATH,content_type="text")    
            #content_type="text/plain"

    elif "6" in request.GET:
            sql_file="xsql_full_text"
            sql_file_path= SQL_FILE_DIR + sql_file +'.sql'
            try:
               os.remove(sql_file_path)
            except OSError:
               pass    
            
            f=open(sql_file_path,'w')
            print("set markup html on ",file=f)
            print("SET SQLBLANKLINES ON",file=f)
        
            for rec in Dbamenu.objects.filter(task_number=6).all():
                print(rec.task_sqlquery,file=f)
            f.close()
                       
            (SQLFILE_FULL_PATH,LOGFILE_FULL_PATH,dbstring) = db_query_location_path2(sql_file,SQL_FILE_DIR,LOG_FILE_DIR,username,db_tns)
            arglist = []
            arg1=request.GET["6_1_option"]
            arglist.append(arg1) 
            exec_db_qry_local_html_list(SQLFILE_FULL_PATH,LOGFILE_FULL_PATH,dbstring,arglist)
            try:
                os.remove(sql_file_path)
            except OSError:
                pass    
            
            return render(request,LOGFILE_FULL_PATH)   
            
    elif "7" in request.GET:  
            sql_file="xstale_stat_sqlid"
            sql_file_path= SQL_FILE_DIR + sql_file +'.sql'
            try:
               os.remove(sql_file_path)
            except OSError:
               pass    
            
            f=open(sql_file_path,'w')
            print("set markup html on ",file=f)
            print("SET SQLBLANKLINES ON",file=f)
        
            for rec in Dbamenu.objects.filter(task_number=7).all():
                print(rec.task_sqlquery,file=f)
            f.close()

            (SQLFILE_FULL_PATH,LOGFILE_FULL_PATH,dbstring) = db_query_location_path(sql_file,username,db_tns)
            
            arglist=[]
            arglist.append(request.GET["7_1_option"])
            exec_db_qry_local_html_list(SQLFILE_FULL_PATH,LOGFILE_FULL_PATH,dbstring,arglist) 
            try:
               os.remove(sql_file_path)
            except OSError:
               pass
            return render(request,LOGFILE_FULL_PATH)
    
    elif "8" in request.GET:  
            sql_file="xsess_kill"
            sql_file_path= SQL_FILE_DIR + sql_file +'.sql'
            try:
               os.remove(sql_file_path)
            except OSError:
               pass    
            
            f=open(sql_file_path,'w')
            print("set markup html on ",file=f)
            print("SET SQLBLANKLINES ON",file=f)
        
            for rec in Dbamenu.objects.filter(task_number=8).all():
                print(rec.task_sqlquery,file=f)
            f.close()
            (SQLFILE_FULL_PATH,LOGFILE_FULL_PATH,dbstring) = db_query_location_path(sql_file,username,db_tns)
            arg1=request.GET["8_1_option"]
            arglist=[]
            arglist.append(arg1)
            exec_db_qry_local_html_list(SQLFILE_FULL_PATH,LOGFILE_FULL_PATH,dbstring,arglist)
            try:
               os.remove(sql_file_path)
            except OSError:
               pass   
            return render(request,LOGFILE_FULL_PATH)
		
    elif "9" in request.GET:  
            sql_file="new_ashrpti"
            (SQLFILE_FULL_PATH,LOGFILE_FULL_PATH,dbstring) = db_query_location_path(sql_file,username,db_tns)
            arg1=request.GET["9_1_option"]   #inst id
            arg2=request.GET["9_2_option"]   #session id
            if arg2 == 0:
                arg2 = ""
            arg3=request.GET["9_3_option"]   #sqlid
            arg4=request.GET["9_4_option"]   #start date
            arg5=request.GET["9_41_option"]   #start time
            arg6=request.GET["9_5_option"]   #duration  
             
            start_date= arg4+' '+arg5    # default yyyy-mm-dd hh24:mi
            start_dt_fmt= datetime.datetime.strptime(start_date,'%Y-%m-%d %H:%M')
            start_dt_fmt2=start_dt_fmt.strftime('%m/%d/%y %H:%M')
            OUTPUT_FILE_NAME=os.path.dirname(LOGFILE_FULL_PATH)+"/ash_rpt_"+os.path.basename(LOGFILE_FULL_PATH)

            arglist = []
            arglist.append(arg1)
            arglist.append(arg2)
            arglist.append(arg3)
            arglist.append(start_dt_fmt2)
            arglist.append(arg6)
            arglist.append(OUTPUT_FILE_NAME)
            exec_db_qry_local_html_list(SQLFILE_FULL_PATH,LOGFILE_FULL_PATH,dbstring,arglist)
          
            if os.path.isfile(OUTPUT_FILE_NAME):
               return render(request,OUTPUT_FILE_NAME) 
            elif os.path.isfile(LOGFILE_FULL_PATH):
               return render(request,LOGFILE_FULL_PATH)
            else:
               message = "Something wrong while executing query file " +sql_file
               return HttpResponse(message)

    elif "10" in request.GET:
            sql_file="k_awrsqrpi"
            
            (SQLFILE_FULL_PATH,LOGFILE_FULL_PATH,dbstring) = db_query_location_path(sql_file,username,db_tns)
             
            arg1=request.GET["10_1_option"]
            arg2=request.GET["10_2_option"]
            arg3=request.GET["10_21_option"]
            arg4=request.GET["10_3_option"]
            arg5=request.GET["10_31_option"]
             
            start_date= arg2+' '+arg3     # default yyyy-mm-dd hh24:mi
            end_date= arg4+' '+arg5     # default yyyy-mm-dd hh24:mi 
            
            OUTPUT_FILE_NAME=os.path.dirname(LOGFILE_FULL_PATH)+"/awr_sql_"+os.path.basename(LOGFILE_FULL_PATH)
            arglist = []
            arglist.append(start_date)
            arglist.append(end_date) 
            arglist.append(arg1)    #sqlid
            arglist.append(OUTPUT_FILE_NAME)
            exec_db_qry_local_html_list(SQLFILE_FULL_PATH,LOGFILE_FULL_PATH,dbstring,arglist)
            
            if os.path.isfile(OUTPUT_FILE_NAME):
               return render(request,OUTPUT_FILE_NAME) 
            elif os.path.isfile(LOGFILE_FULL_PATH):
               return render(request,LOGFILE_FULL_PATH)
            else:
               message = "Something wrong while executing query file " +sql_file
               return HttpResponse(message) 

    elif "11" in request.GET:  
            sql_file="xplan_change_daily_report"
            sql_file_path= SQL_FILE_DIR + sql_file +'.sql'
            try:
               os.remove(sql_file_path)
            except OSError:
               pass    
            
            f=open(sql_file_path,'w')
            print("set markup html on ",file=f)
            print("SET SQLBLANKLINES ON",file=f)
        
            for rec in Dbamenu.objects.filter(task_number=11).all():
                print(rec.task_sqlquery,file=f)
            f.close()

            (SQLFILE_FULL_PATH,LOGFILE_FULL_PATH,dbstring) = db_query_location_path(sql_file,username,db_tns)
            arg1=request.GET["11_1_option"]
            arglist = []
            arglist.append(arg1)
            exec_db_qry_local_html_list(SQLFILE_FULL_PATH,LOGFILE_FULL_PATH,dbstring,arglist)
            try:
               os.remove(sql_file_path)
            except OSError:
               pass  
            return render(request,LOGFILE_FULL_PATH)

    elif "12" in request.GET:  
            sql_file="xtable_stats"
            sql_file_path= SQL_FILE_DIR + sql_file +'.sql'
            try:
               os.remove(sql_file_path)
            except OSError:
               pass    
            
            f=open(sql_file_path,'w')
            print("set markup html on ",file=f)
            print("SET SQLBLANKLINES ON",file=f)
        
            for rec in Dbamenu.objects.filter(task_number=12).all():
                print(rec.task_sqlquery,file=f)
            f.close()
            (SQLFILE_FULL_PATH,LOGFILE_FULL_PATH,dbstring) = db_query_location_path(sql_file,username,db_tns)
            arg1=request.GET["12_1_option"]
            arg2=request.GET["12_2_option"]
            arglist=[]
            arglist.append(arg1)
            arglist.append(arg2)
            exec_db_qry_local_html_list(SQLFILE_FULL_PATH,LOGFILE_FULL_PATH,dbstring,arglist)
            try:
               os.remove(sql_file_path)
            except OSError:
               pass  
            return render(request,LOGFILE_FULL_PATH)
			
    elif "13" in request.GET:
            sql_file = "xsystemevent"   # previous option k_sqldiag_REC11.sh
            sql_file_path= SQL_FILE_DIR + sql_file +'.sql'
            try:
               os.remove(sql_file_path)
            except OSError:
               pass    
            
            f=open(sql_file_path,'w')
            print("set markup html on ",file=f)
            print("SET SQLBLANKLINES ON",file=f)
        
            for rec in Dbamenu.objects.filter(task_number=13).all():
                print(rec.task_sqlquery,file=f)
            f.close()
                       
            (SQLFILE_FULL_PATH,LOGFILE_FULL_PATH,dbstring) = db_query_location_path2(sql_file,SQL_FILE_DIR,LOG_FILE_DIR,username,db_tns)
            arglist = []
            exec_db_qry_local_html_list(SQLFILE_FULL_PATH,LOGFILE_FULL_PATH,dbstring,arglist)
            try:
                os.remove(sql_file_path)
            except OSError:
                pass    
            
            return render(request,LOGFILE_FULL_PATH) 
            
    elif "14" in request.GET:  
            sql_file="xtop_cpu"
            sql_file_path= SQL_FILE_DIR + sql_file +'.sql'
            try:
               os.remove(sql_file_path)
            except OSError:
               pass    
            
            f=open(sql_file_path,'w')
            print("set markup html on ",file=f)
            print("SET SQLBLANKLINES ON",file=f)
        
            for rec in Dbamenu.objects.filter(task_number=14).all():
                print(rec.task_sqlquery,file=f)
            f.close()
                       
            (SQLFILE_FULL_PATH,LOGFILE_FULL_PATH,dbstring) = db_query_location_path2(sql_file,SQL_FILE_DIR,LOG_FILE_DIR,username,db_tns)
            arglist = []
            exec_db_qry_local_html_list(SQLFILE_FULL_PATH,LOGFILE_FULL_PATH,dbstring,arglist)
            try:
                os.remove(sql_file_path)
            except OSError:
                pass    
            
            return render(request,LOGFILE_FULL_PATH) 
	
    elif "15" in request.GET:  
            sql_file="xblockers_rac"
            sql_file_path= SQL_FILE_DIR + sql_file +'.sql'
            try:
               os.remove(sql_file_path)
            except OSError:
               pass    
            
            f=open(sql_file_path,'w')
            print("set markup html on ",file=f)
            print("SET SQLBLANKLINES ON",file=f)
        
            for rec in Dbamenu.objects.filter(task_number=15).all():
                print(rec.task_sqlquery,file=f)
            f.close()
                       
            (SQLFILE_FULL_PATH,LOGFILE_FULL_PATH,dbstring) = db_query_location_path2(sql_file,SQL_FILE_DIR,LOG_FILE_DIR,username,db_tns)
            arglist = []
            exec_db_qry_local_html_list(SQLFILE_FULL_PATH,LOGFILE_FULL_PATH,dbstring,arglist)
            try:
                os.remove(sql_file_path)
            except OSError:
                pass    
            
            return render(request,LOGFILE_FULL_PATH)  
	
    elif "16" in request.GET:  
            sql_file="xlatch_wait_rac"
            sql_file_path= SQL_FILE_DIR + sql_file +'.sql'
            try:
               os.remove(sql_file_path)
            except OSError:
               pass    
            
            f=open(sql_file_path,'w')
            print("set markup html on ",file=f)
            print("SET SQLBLANKLINES ON",file=f)
        
            for rec in Dbamenu.objects.filter(task_number=16).all():
                print(rec.task_sqlquery,file=f)
            f.close()
            (SQLFILE_FULL_PATH,LOGFILE_FULL_PATH,dbstring) = db_query_location_path(sql_file,username,db_tns)
            
            arglist=[]
            exec_db_qry_local_html_list(SQLFILE_FULL_PATH,LOGFILE_FULL_PATH,dbstring,arglist) 
            try:
               os.remove(sql_file_path)
            except OSError:
               pass
            return render(request,LOGFILE_FULL_PATH)
	
    elif "17" in request.GET:
            sql_file="xshow_sess_usr_hist_top_io"
            sql_file_path= SQL_FILE_DIR + sql_file +'.sql'
            try:
               os.remove(sql_file_path)
            except OSError:
               pass    
            
            f=open(sql_file_path,'w')
            print("set markup html on ",file=f)
            print("SET SQLBLANKLINES ON",file=f)
        
            for rec in Dbamenu.objects.filter(task_number=17).all():
                print(rec.task_sqlquery,file=f)
            f.close()
            (SQLFILE_FULL_PATH,LOGFILE_FULL_PATH,dbstring) = db_query_location_path(sql_file,username,db_tns)
            arg1=request.GET["17_1_option"]
            arg2=request.GET["17_11_option"]
            arg3=request.GET["17_2_option"]
            arg4=request.GET["17_21_option"]

            start_date= arg1+' '+arg2     # default yyyy-mm-dd hh24:mi
            end_date= arg3+' '+arg4     # default yyyy-mm-dd hh24:mi

            arglist=[]
            arglist.append(start_date)
            arglist.append(end_date)
            exec_db_qry_local_html_list(SQLFILE_FULL_PATH,LOGFILE_FULL_PATH,dbstring,arglist)
            try:
               os.remove(sql_file_path)
            except OSError:
               pass  
            return render(request,LOGFILE_FULL_PATH)  
            
    

    elif "18" in request.GET:
            sql_file="xshow_hist_top_cpu_usage"
            sql_file_path= SQL_FILE_DIR + sql_file +'.sql'
            try:
               os.remove(sql_file_path)
            except OSError:
               pass    
            
            f=open(sql_file_path,'w')
            print("set markup html on ",file=f)
            print("SET SQLBLANKLINES ON",file=f)
        
            for rec in Dbamenu.objects.filter(task_number=18).all():
                print(rec.task_sqlquery,file=f)
            f.close()
            (SQLFILE_FULL_PATH,LOGFILE_FULL_PATH,dbstring) = db_query_location_path(sql_file,username,db_tns)
            arg1=request.GET["18_1_option"]
            arg2=request.GET["18_11_option"]
            arg3=request.GET["18_2_option"]
            arg4=request.GET["18_21_option"]

            start_date= arg1+' '+arg2     # default yyyy-mm-dd hh24:mi
            end_date= arg3+' '+arg4     # default yyyy-mm-dd hh24:mi

            arglist=[]
            arglist.append(start_date)
            arglist.append(end_date)
            exec_db_qry_local_html_list(SQLFILE_FULL_PATH,LOGFILE_FULL_PATH,dbstring,arglist)
            try:
               os.remove(sql_file_path)
            except OSError:
               pass  
            return render(request,LOGFILE_FULL_PATH)  

    elif "19" in request.GET:  
            sql_file="xshow_hist_top_obj_wait"
            sql_file_path= SQL_FILE_DIR + sql_file +'.sql'
            try:
               os.remove(sql_file_path)
            except OSError:
               pass    
            
            f=open(sql_file_path,'w')
            print("set markup html on ",file=f)
            print("SET SQLBLANKLINES ON",file=f)
        
            for rec in Dbamenu.objects.filter(task_number=19).all():
                print(rec.task_sqlquery,file=f)
            f.close()
            (SQLFILE_FULL_PATH,LOGFILE_FULL_PATH,dbstring) = db_query_location_path(sql_file,username,db_tns)

            arg1=request.GET["19_1_option"]
            arg2=request.GET["19_11_option"]
            arg3=request.GET["19_2_option"]
            arg4=request.GET["19_21_option"]

            start_date= arg1+' '+arg2     # default yyyy-mm-dd hh24:mi
            end_date= arg3+' '+arg4     # default yyyy-mm-dd hh24:mi

            arglist=[]
            arglist.append(start_date)
            arglist.append(end_date)
            exec_db_qry_local_html_list(SQLFILE_FULL_PATH,LOGFILE_FULL_PATH,dbstring,arglist)
            try:
               os.remove(sql_file_path)
            except OSError:
               pass  
            return render(request,LOGFILE_FULL_PATH)  
	
    elif "20" in request.GET:    
          #    sql_file="xshow_sess_hist_wait_blocked" #  Only blocked or waited
            sql_file="xshow_sess_hist_wait_blocked"
            sql_file_path= SQL_FILE_DIR + sql_file +'.sql'
            try:
               os.remove(sql_file_path)
            except OSError:
               pass    
            
            f=open(sql_file_path,'w')
            print("set markup html on ",file=f)
            print("SET SQLBLANKLINES ON",file=f)
        
            for rec in Dbamenu.objects.filter(task_number=20).all():
                print(rec.task_sqlquery,file=f)
            f.close()

            (SQLFILE_FULL_PATH,LOGFILE_FULL_PATH,dbstring) = db_query_location_path(sql_file,username,db_tns)
            arg1=request.GET["20_1_option"]  # username
            arg2=request.GET["20_2_option"]  # start date only 
            arg3=request.GET["20_21_option"]  # start time only
            arg4=request.GET["20_3_option"]  # end date only
            arg5=request.GET["20_31_option"]  # end time only

            start_date= arg2+' '+arg3     # default yyyy-mm-dd hh24:mi
            end_date= arg4+' '+arg5     # default yyyy-mm-dd hh24:mi

            arglist=[]
            arglist.append(arg1)
            arglist.append(start_date)
            arglist.append(end_date)
            
            exec_db_qry_local_html_list(SQLFILE_FULL_PATH,LOGFILE_FULL_PATH,dbstring,arglist)
            try:
               os.remove(sql_file_path)
            except OSError:
               pass
            return render(request,LOGFILE_FULL_PATH) 
	
    elif "21" in request.GET:  
             #    sql_file="xshow_sess_hist_wait_blocked" #  ALL
            sql_file = "xshow_sess_hist_wait_all" 
            
            #else:
            #    sql_file="show_sess_ops_usr_hist2"
            sql_file_path= SQL_FILE_DIR + sql_file +'.sql'
            try:
               os.remove(sql_file_path)
            except OSError:
               pass    
            
            f=open(sql_file_path,'w')
            print("set markup html on ",file=f)
            print("SET SQLBLANKLINES ON",file=f)
        
            for rec in Dbamenu.objects.filter(task_number=21).all():
                print(rec.task_sqlquery,file=f)
            f.close()

            (SQLFILE_FULL_PATH,LOGFILE_FULL_PATH,dbstring) = db_query_location_path(sql_file,username,db_tns)
            arg1=request.GET["21_1_option"]
            arg2=request.GET["21_2_option"]
            arg3=request.GET["21_21_option"]
            arg4=request.GET["21_3_option"]
            arg5=request.GET["21_31_option"]

            start_date= arg2+' '+arg3     # default yyyy-mm-dd hh24:mi
            end_date= arg4+' '+arg5     # default yyyy-mm-dd hh24:mi

            arglist=[]
            arglist.append(arg1)
            arglist.append(start_date)
            arglist.append(end_date)
            exec_db_qry_local_html_list(SQLFILE_FULL_PATH,LOGFILE_FULL_PATH,dbstring,arglist)
            try:
               os.remove(sql_file_path)
            except OSError:
               pass 
            return render(request,LOGFILE_FULL_PATH)  

	
    elif  "22" in request.GET: 
   
            sql_file="xshow_sess_hist_run_time"

            sql_file_path= SQL_FILE_DIR + sql_file +'.sql'
            try:
               os.remove(sql_file_path)
            except OSError:
               pass    
            
            f=open(sql_file_path,'w')
            print("set markup html on ",file=f)
            print("SET SQLBLANKLINES ON",file=f)
        
            for rec in Dbamenu.objects.filter(task_number=22).all():
                print(rec.task_sqlquery,file=f)
            f.close()

            (SQLFILE_FULL_PATH,LOGFILE_FULL_PATH,dbstring) = db_query_location_path(sql_file,username,db_tns)
            arg1=request.GET["22_1_option"]  # sqlid 
            arg2=request.GET["22_2_option"]  # start date only 
            arg3=request.GET["22_21_option"]  # start time only
            arg4=request.GET["22_3_option"]  # end date only
            arg5=request.GET["22_31_option"]  # end time only

            start_date= arg2+' '+arg3     # default yyyy-mm-dd hh24:mi
            end_date= arg4+' '+arg5     # default yyyy-mm-dd hh24:mi

            arglist=[]
            arglist.append(arg1)
            arglist.append(start_date)
            arglist.append(end_date)
            
            exec_db_qry_local_html_list(SQLFILE_FULL_PATH,LOGFILE_FULL_PATH,dbstring,arglist)
            try:
               os.remove(sql_file_path)
            except OSError:
               pass
            return render(request,LOGFILE_FULL_PATH) 	
	
    elif "23" in request.GET:  
            sql_file="xshow_qry_sess_run_time"
 
            sql_file_path= SQL_FILE_DIR + sql_file +'.sql'
            try:
               os.remove(sql_file_path)
            except OSError:
               pass    
            
            f=open(sql_file_path,'w')
            print("set markup html on ",file=f)
            print("SET SQLBLANKLINES ON",file=f)
        
            for rec in Dbamenu.objects.filter(task_number=23).all():
                print(rec.task_sqlquery,file=f)
            f.close()

            (SQLFILE_FULL_PATH,LOGFILE_FULL_PATH,dbstring) = db_query_location_path(sql_file,username,db_tns)
            arg1=request.GET["23_1_option"]  # sqlid 
            arg2=request.GET["23_2_option"]  # start date only 
            arg3=request.GET["23_21_option"]  # start time only
            arg4=request.GET["23_3_option"]  # end date only
            arg5=request.GET["23_31_option"]  # end time only

            start_date= arg2+' '+arg3     # default yyyy-mm-dd hh24:mi
            end_date= arg4+' '+arg5     # default yyyy-mm-dd hh24:mi

            arglist=[]
            arglist.append(arg1)
            arglist.append(start_date)
            arglist.append(end_date)
            
            exec_db_qry_local_html_list(SQLFILE_FULL_PATH,LOGFILE_FULL_PATH,dbstring,arglist)
            try:
               os.remove(sql_file_path)
            except OSError:
               pass
            return render(request,LOGFILE_FULL_PATH) 	
	
    elif "24" in request.GET:
            sql_file="xqry_addm_all"
            sql_file_path= SQL_FILE_DIR + sql_file +'.sql'
            try:
               os.remove(sql_file_path)
            except OSError:
               pass    
            
            f=open(sql_file_path,'w')
            print("set markup html on ",file=f)
            print("SET SQLBLANKLINES ON",file=f)
        
            for rec in Dbamenu.objects.filter(task_number=24).all():
                print(rec.task_sqlquery,file=f)
            f.close()
            (SQLFILE_FULL_PATH,LOGFILE_FULL_PATH,dbstring) = db_query_location_path(sql_file,username,db_tns)
            arg1=request.GET["24_1_option"]
            arg2=request.GET["24_11_option"]
            arg3=request.GET["24_2_option"]
            arg4=request.GET["24_21_option"]

            start_date= arg1+' '+arg2     # default yyyy-mm-dd hh24:mi
            end_date= arg3+' '+arg4     # default yyyy-mm-dd hh24:mi

            arglist=[]
            arglist.append(start_date)
            arglist.append(end_date)
            exec_db_qry_local_html_list(SQLFILE_FULL_PATH,LOGFILE_FULL_PATH,dbstring,arglist)
            try:
               os.remove(sql_file_path)
            except OSError:
               pass  
            return render(request,LOGFILE_FULL_PATH)  
			
    elif "25" in request.GET:  
            sql_file="xarch_log_hist_qry"
            sql_file_path= SQL_FILE_DIR + sql_file +'.sql'
            try:
               os.remove(sql_file_path)
            except OSError:
               pass    
            
            f=open(sql_file_path,'w')
            print("set markup html on ",file=f)
            print("SET SQLBLANKLINES ON",file=f)
        
            for rec in Dbamenu.objects.filter(task_number=25).all():
                print(rec.task_sqlquery,file=f)
            f.close()
            (SQLFILE_FULL_PATH,LOGFILE_FULL_PATH,dbstring) = db_query_location_path(sql_file,username,db_tns)
            arglist=[]
            exec_db_qry_local_html_list(SQLFILE_FULL_PATH,LOGFILE_FULL_PATH,dbstring,arglist)
            try:
               os.remove(sql_file_path)
            except OSError:
               pass  
            return render(request,LOGFILE_FULL_PATH)   

    elif  "26" in request.GET: 
            sql_file="xalert_qry"
            sql_file_path= SQL_FILE_DIR + sql_file +'.sql'
            try:
               os.remove(sql_file_path)
            except OSError:
               pass    
            
            f=open(sql_file_path,'w')
            print("set markup html on ",file=f)
            print("SET SQLBLANKLINES ON",file=f)
        
            for rec in Dbamenu.objects.filter(task_number=26).all():
                print(rec.task_sqlquery,file=f)
            f.close()
            (SQLFILE_FULL_PATH,LOGFILE_FULL_PATH,dbstring) = db_query_location_path(sql_file,username,db_tns)
            arglist=[]
            exec_db_qry_local_html_list(SQLFILE_FULL_PATH,LOGFILE_FULL_PATH,dbstring,arglist)
            try:
               os.remove(sql_file_path)
            except OSError:
               pass   
            return render(request,LOGFILE_FULL_PATH) 			

    elif "27" in request.GET:  
            if request.GET["awrsnaptype"] == "singlesnap":
                sql_file="awrrpti"    # awr for single instance  for singlesnap
            else:    
                sql_file="awrddrpi"    # awr for comparision for multisnap  
            arglist=[]
            arglist.append(request.GET["45_1_option"]) 
            arglist.append(request.GET["45_2_option"])
            arglist.append(request.GET["45_3_option"])
            if (request.GET["45_4_option"] !="" and request.GET["45_5_option"] !="" and request.GET["45_6_option"] !=""):
               arglist.append(request.GET["45_4_option"]) 
               arglist.append(request.GET["45_5_option"])
               arglist.append(request.GET["45_6_option"])
            
            (SQLFILE_FULL_PATH,LOGFILE_FULL_PATH,dbstring) = db_query_location_path(sql_file,username,db_tns)
            OUTPUT_FILE_NAME=os.path.dirname(LOGFILE_FULL_PATH)+"/awr_rpt_"+os.path.basename(LOGFILE_FULL_PATH)
            arglist.append(OUTPUT_FILE_NAME)
            exec_db_qry_local_html_list(SQLFILE_FULL_PATH,LOGFILE_FULL_PATH,dbstring,arglist)
            return render(request,OUTPUT_FILE_NAME) 

    elif "28" in request.GET:
            sql_file="xsortspace"
            sql_file_path= SQL_FILE_DIR + sql_file +'.sql'
            try:
               os.remove(sql_file_path)
            except OSError:
               pass    
            
            f=open(sql_file_path,'w')
            print("set markup html on ",file=f)
            print("SET SQLBLANKLINES ON",file=f)
        
            for rec in Dbamenu.objects.filter(task_number=28).all():
                print(rec.task_sqlquery,file=f)
            f.close()
            (SQLFILE_FULL_PATH,LOGFILE_FULL_PATH,dbstring) = db_query_location_path(sql_file,username,db_tns)
            arglist=[]
            exec_db_qry_local_html_list(SQLFILE_FULL_PATH,LOGFILE_FULL_PATH,dbstring,arglist)
            try:
               os.remove(sql_file_path)
            except OSError:
               pass  
            return render(request,LOGFILE_FULL_PATH)  


    elif "29" in request.GET:  
            sql_file="xshowsessions_active"
             
            arg1=request.GET["29_1_option"]
            if  arg1==request.GET["29_1_option"] == "":
                    arg1='%'
             
            sql_file_path= SQL_FILE_DIR + sql_file +'.sql'
            try:
               os.remove(sql_file_path)
            except OSError:
               pass    
            
            f=open(sql_file_path,'w')
            print("set markup html on ",file=f)
            print("SET SQLBLANKLINES ON",file=f)
        
            for rec in Dbamenu.objects.filter(task_number=29).all():
                print(rec.task_sqlquery,file=f)
            f.close()
                       
            (SQLFILE_FULL_PATH,LOGFILE_FULL_PATH,dbstring) = db_query_location_path2(sql_file,SQL_FILE_DIR,LOG_FILE_DIR,username,db_tns)
            arglist = []
            arglist.append(arg1)
            exec_db_qry_local_html_list(SQLFILE_FULL_PATH,LOGFILE_FULL_PATH,dbstring,arglist)
            try:
                os.remove(sql_file_path)
            except OSError:
                pass    
            
            return render(request,LOGFILE_FULL_PATH)

    elif  "30" in request.GET: 
            sql_file="xrac_long_run_txn"
            sql_file_path= SQL_FILE_DIR + sql_file +'.sql'
            try:
               os.remove(sql_file_path)
            except OSError:
               pass    
            
            f=open(sql_file_path,'w')
            print("set markup html on ",file=f)
            print("SET SQLBLANKLINES ON",file=f)
        
            for rec in Dbamenu.objects.filter(task_number=30).all():
                print(rec.task_sqlquery,file=f)
            f.close()
                       
            (SQLFILE_FULL_PATH,LOGFILE_FULL_PATH,dbstring) = db_query_location_path2(sql_file,SQL_FILE_DIR,LOG_FILE_DIR,username,db_tns)
            arglist = []
            exec_db_qry_local_html_list(SQLFILE_FULL_PATH,LOGFILE_FULL_PATH,dbstring,arglist)
            try:
                os.remove(sql_file_path)
            except OSError:
                pass    
            
            return render(request,LOGFILE_FULL_PATH) 
        
    elif "31" in request.GET:
            sql_file="xall_sess_db"
            sql_file_path= SQL_FILE_DIR + sql_file +'.sql'
            try:
               os.remove(sql_file_path)
            except OSError:
               pass    
            
            f=open(sql_file_path,'w')
            print("set markup html on ",file=f)
            print("SET SQLBLANKLINES ON",file=f)
        
            for rec in Dbamenu.objects.filter(task_number=31).all():
                print(rec.task_sqlquery,file=f)
            f.close()
                       
            (SQLFILE_FULL_PATH,LOGFILE_FULL_PATH,dbstring) = db_query_location_path2(sql_file,SQL_FILE_DIR,LOG_FILE_DIR,username,db_tns)
            arglist = []
            exec_db_qry_local_html_list(SQLFILE_FULL_PATH,LOGFILE_FULL_PATH,dbstring,arglist)
            try:
                os.remove(sql_file_path)
            except OSError:
                pass    
            
            return render(request,LOGFILE_FULL_PATH)   
            
    elif "32" in request.GET:  
            sql_file="xlong_open_trans"
            sql_file_path= SQL_FILE_DIR + sql_file +'.sql'
            try:
               os.remove(sql_file_path)
            except OSError:
               pass    
            
            f=open(sql_file_path,'w')
            print("set markup html on ",file=f)
            print("SET SQLBLANKLINES ON",file=f)
        
            for rec in Dbamenu.objects.filter(task_number=32).all():
                print(rec.task_sqlquery,file=f)
            f.close()
            (SQLFILE_FULL_PATH,LOGFILE_FULL_PATH,dbstring) = db_query_location_path(sql_file,username,db_tns)
            arglist=[]
            exec_db_qry_local_html_list(SQLFILE_FULL_PATH,LOGFILE_FULL_PATH,dbstring,arglist)
            try:
               os.remove(sql_file_path)
            except OSError:
               pass  
            return render(request,LOGFILE_FULL_PATH)  
			
    elif "33" in request.GET:  
            sql_file="xtbs_free_autoextend"
            sql_file_path= SQL_FILE_DIR + sql_file +'.sql'
            try:
               os.remove(sql_file_path)
            except OSError:
               pass    
            
            f=open(sql_file_path,'w')
            print("set markup html on ",file=f)
            print("SET SQLBLANKLINES ON",file=f)
        
            for rec in Dbamenu.objects.filter(task_number=33).all():
                print(rec.task_sqlquery,file=f)
            f.close()

            (SQLFILE_FULL_PATH,LOGFILE_FULL_PATH,dbstring) = db_query_location_path(sql_file,username,db_tns)
            arg1=request.GET["33_1_option"]
            arglist=[]
            arglist.append(arg1)
            exec_db_qry_local_html_list(SQLFILE_FULL_PATH,LOGFILE_FULL_PATH,dbstring,arglist)
            try:
               os.remove(sql_file_path)
            except OSError:
               pass 
            return render(request,LOGFILE_FULL_PATH)   

    
            
    elif "35" in request.GET:  
            sql_file="xundo_details"
            sql_file_path= SQL_FILE_DIR + sql_file +'.sql'
            try:
               os.remove(sql_file_path)
            except OSError:
               pass    
            
            f=open(sql_file_path,'w')
            print("set markup html on ",file=f)
            print("SET SQLBLANKLINES ON",file=f)
        
            for rec in Dbamenu.objects.filter(task_number=35).all():
                print(rec.task_sqlquery,file=f)
            f.close()
            (SQLFILE_FULL_PATH,LOGFILE_FULL_PATH,dbstring) = db_query_location_path(sql_file,username,db_tns)
            arglist=[]
            exec_db_qry_local_html_list(SQLFILE_FULL_PATH,LOGFILE_FULL_PATH,dbstring,arglist)
            try:
               os.remove(sql_file_path)
            except OSError:
               pass   
            return render(request,LOGFILE_FULL_PATH)	
	
    elif "36" in request.GET:
            sql_file="xasm_diskgroups"
            sql_file_path= SQL_FILE_DIR + sql_file +'.sql'
            try:
               os.remove(sql_file_path)
            except OSError:
               pass    
            
            f=open(sql_file_path,'w')
            print("set markup html on ",file=f)
            print("SET SQLBLANKLINES ON",file=f)
        
            for rec in Dbamenu.objects.filter(task_number=36).all():
                print(rec.task_sqlquery,file=f)
            f.close()
            (SQLFILE_FULL_PATH,LOGFILE_FULL_PATH,dbstring) = db_query_location_path(sql_file,username,db_tns)
            arglist=[]
            exec_db_qry_local_html_list(SQLFILE_FULL_PATH,LOGFILE_FULL_PATH,dbstring,arglist) 
            try:
               os.remove(sql_file_path)
            except OSError:
               pass 
            return render(request,LOGFILE_FULL_PATH)  
            
    elif "37" in request.GET:  
            sql_file="xasm_disks_perf"
            sql_file_path= SQL_FILE_DIR + sql_file +'.sql'
            try:
               os.remove(sql_file_path)
            except OSError:
               pass    
            
            f=open(sql_file_path,'w')
            print("set markup html on ",file=f)
            print("SET SQLBLANKLINES ON",file=f)
        
            for rec in Dbamenu.objects.filter(task_number=37).all():
                print(rec.task_sqlquery,file=f)
            f.close()
            (SQLFILE_FULL_PATH,LOGFILE_FULL_PATH,dbstring) = db_query_location_path(sql_file,username,db_tns)
            arglist=[]
            exec_db_qry_local_html_list(SQLFILE_FULL_PATH,LOGFILE_FULL_PATH,dbstring,arglist) 
            try:
               os.remove(sql_file_path)
            except OSError:
               pass 
            return render(request,LOGFILE_FULL_PATH)
     
            
    elif "38" in request.GET:
            sql_file="xrman_details"
            sql_file_path= SQL_FILE_DIR + sql_file +'.sql'
            try:
               os.remove(sql_file_path)
            except OSError:
               pass    
            
            f=open(sql_file_path,'w')
            print("set markup html on ",file=f)
            print("SET SQLBLANKLINES ON",file=f)
        
            for rec in Dbamenu.objects.filter(task_number=38).all():
                print(rec.task_sqlquery,file=f)
            f.close()
            (SQLFILE_FULL_PATH,LOGFILE_FULL_PATH,dbstring) = db_query_location_path(sql_file,username,db_tns)
            arglist=[]
            exec_db_qry_local_html_list(SQLFILE_FULL_PATH,LOGFILE_FULL_PATH,dbstring,arglist)
            try:
               os.remove(sql_file_path)
            except OSError:
               pass  
            return render(request,LOGFILE_FULL_PATH)  
            
    elif "39" in request.GET:  
            sql_file="xdb_service_all"
            sql_file_path= SQL_FILE_DIR + sql_file +'.sql'
            try:
               os.remove(sql_file_path)
            except OSError:
               pass    
            
            f=open(sql_file_path,'w')
            print("set markup html on ",file=f)
            print("SET SQLBLANKLINES ON",file=f)
        
            for rec in Dbamenu.objects.filter(task_number=39).all():
                print(rec.task_sqlquery,file=f)
            f.close()
            (SQLFILE_FULL_PATH,LOGFILE_FULL_PATH,dbstring) = db_query_location_path(sql_file,username,db_tns)
            arglist=[]
            exec_db_qry_local_html_list(SQLFILE_FULL_PATH,LOGFILE_FULL_PATH,dbstring,arglist)
            try:
               os.remove(sql_file_path)
            except OSError:
               pass 
            return render(request,LOGFILE_FULL_PATH) 

    elif "40" in request.GET:  
            from django.conf import settings
            LOGFILE_FULL_PATH= settings.BASE_DIR + '/dbawebmenu/templates/dbawebmenu/logfile/'
            
            mypath = LOGFILE_FULL_PATH
            logfile_dir_name=os.path.dirname(mypath)
            onlylogfiles = [f for f in listdir(mypath) if isfile(join(mypath, f))]
    
	      # Render the HTML template index.html with the data in the context variable.
            return render(request,'dbawebmenu/dbamenu_listlogfiles.html',
               context={'logfile_dir_name':logfile_dir_name,'onlylogfiles':onlylogfiles},)
	
    
    elif "99" in request.GET: 
            if request.GET["sqltype"] == "PROGRESS":
                sql_file="progress_sqlid"  
                (SQLFILE_FULL_PATH,LOGFILE_FULL_PATH,dbstring) = db_query_location_path(sql_file,username,db_tns)
                arglist=[]  
                arglist.append(request.GET["99_1_option"])
                exec_db_qry_local_html_list(SQLFILE_FULL_PATH,LOGFILE_FULL_PATH,dbstring,arglist) 
                return render(request,LOGFILE_FULL_PATH)  

            elif request.GET["sqltype"] == "PLANHIST":
                sql_file="sql_plan_changes_apps"  
                (SQLFILE_FULL_PATH,LOGFILE_FULL_PATH,dbstring) = db_query_location_path(sql_file,username,db_tns)
                arglist=[]  
                arglist.append(request.GET["99_1_option"])
                exec_db_qry_local_html_list(SQLFILE_FULL_PATH,LOGFILE_FULL_PATH,dbstring,arglist) 
                return render(request,LOGFILE_FULL_PATH)  
                                  
            elif request.GET["sqltype"] == "QRYTXT":
                sql_file="sql_full_text_apps"  
                (SQLFILE_FULL_PATH,LOGFILE_FULL_PATH,dbstring) = db_query_location_path(sql_file,username,db_tns)
                arglist=[]  
                arglist.append(request.GET["99_1_option"])
                exec_db_qry_local_html_list(SQLFILE_FULL_PATH,LOGFILE_FULL_PATH,dbstring,arglist) 
                return render(request,LOGFILE_FULL_PATH)      
                         
            elif request.GET["sqltype"] == "SQLIDSESS":
                sql_file="showsessions_ops_usr"  
                (SQLFILE_FULL_PATH,LOGFILE_FULL_PATH,dbstring) = db_query_location_path(sql_file,username,db_tns)
                arglist=[]  
                arglist.append(request.GET["99_1_option"])
                exec_db_qry_local_html_list(SQLFILE_FULL_PATH,LOGFILE_FULL_PATH,dbstring,arglist) 
                return render(request,LOGFILE_FULL_PATH) 

            elif request.GET["sqltype"] == "STALESTATS":
                sql_file="stale_stat_sqlid"  
                (SQLFILE_FULL_PATH,LOGFILE_FULL_PATH,dbstring) = db_query_location_path(sql_file,username,db_tns)
                arglist=[]  
                arglist.append(request.GET["99_1_option"])
                exec_db_qry_local_html_list(SQLFILE_FULL_PATH,LOGFILE_FULL_PATH,dbstring,arglist) 
                return render(request,LOGFILE_FULL_PATH)    

            elif request.GET["sqltype"] == "CUREXPLN":
                sql_file="xplan_sqlid"  
                (SQLFILE_FULL_PATH,LOGFILE_FULL_PATH,dbstring) = db_query_location_path(sql_file,username,db_tns)
                arglist=[]  
                arglist.append(request.GET["99_1_option"])
                exec_db_qry_local_html_list(SQLFILE_FULL_PATH,LOGFILE_FULL_PATH,dbstring,arglist) 
                return render(request,LOGFILE_FULL_PATH)  

            elif request.GET["sqltype"] == "BINDHIST":
                sql_file="qry_bind_val"  
                (SQLFILE_FULL_PATH,LOGFILE_FULL_PATH,dbstring) = db_query_location_path(sql_file,username,db_tns)
                arglist=[]  
                arglist.append(request.GET["99_1_option"])
                exec_db_qry_local_html_list(SQLFILE_FULL_PATH,LOGFILE_FULL_PATH,dbstring,arglist) 
                return render(request,LOGFILE_FULL_PATH)   

            elif request.GET["sqltype"] == "CHGSQLID":
                sql_file="change_sqlid"  
                (SQLFILE_FULL_PATH,LOGFILE_FULL_PATH,dbstring) = db_query_location_path(sql_file,username,db_tns)
                arglist=[]  
                arglist.append(request.GET["99_1_option"])
                exec_db_qry_local_html_list(SQLFILE_FULL_PATH,LOGFILE_FULL_PATH,dbstring,arglist) 
                return render(request,LOGFILE_FULL_PATH)   

            elif request.GET["sqltype"] == "SPMCHECK":
                sql_file="spm_created_hist"  
                (SQLFILE_FULL_PATH,LOGFILE_FULL_PATH,dbstring) = db_query_location_path(sql_file,username,db_tns)
                arglist=[]  
                arglist.append(request.GET["99_1_option"])
                exec_db_qry_local_html_list(SQLFILE_FULL_PATH,LOGFILE_FULL_PATH,dbstring,arglist) 
                return render(request,LOGFILE_FULL_PATH)  
            
            elif request.GET["sqltype"] == "CHECKPINPLAN":
                sql_file="qry_execution_time_check" 
                (SQLFILE_FULL_PATH,LOGFILE_FULL_PATH,dbstring) = db_query_location_path(sql_file,username,db_tns)
                arglist=[]  
                arglist.append(request.GET["99_1_option"])
                exec_db_qry_local_html_list(SQLFILE_FULL_PATH,LOGFILE_FULL_PATH,dbstring,arglist) 
                return render(request,LOGFILE_FULL_PATH)    

            elif request.GET["sqltype"] == "FLUSHPLAN":
                sql_file="flush_plan_sess_kill"  
                (SQLFILE_FULL_PATH,LOGFILE_FULL_PATH,dbstring) = db_query_location_path(sql_file,username,db_tns)
                arglist=[]  
                arglist.append(request.GET["99_1_option"])
                exec_db_qry_local_html_list(SQLFILE_FULL_PATH,LOGFILE_FULL_PATH,dbstring,arglist) 
                return render(request,LOGFILE_FULL_PATH)   
                               
            elif request.GET["sqltype"] == "ADDMCHECK":
                sql_file="qry_addm_sqlid"  
                (SQLFILE_FULL_PATH,LOGFILE_FULL_PATH,dbstring) = db_query_location_path(sql_file,username,db_tns)
                arglist=[]  
                arglist.append(request.GET["99_1_option"])
                exec_db_qry_local_html_list(SQLFILE_FULL_PATH,LOGFILE_FULL_PATH,dbstring,arglist) 
                return render(request,LOGFILE_FULL_PATH)                   
  		

## end of dbamenu detail query view

# sql plus execution related view  
def exec_db_qry_local_html_list(sqlqueryfile,htmllogfile,dbstring,arglist):
        sql_file = sqlqueryfile
        NOW=time.strftime('%C%y%m%d-%H%M%S')
        if htmllogfile != "None":
            LOGFILE=htmllogfile
        else:
            LOGFILE=sql_file+"_"+NOW+".html"
        
        try:
            os.remove(LOGFILE)
        except OSError:
            pass
        f = open(LOGFILE,'w')

        argx1 = "sqlplus"
        argx2 = "-S"
        argx3 = dbstring
        argx4 = '@'+sqlqueryfile
        
        newlist=[]
        newlist.append(argx1)
        newlist.append(argx2)
        newlist.append(argx3)
        newlist.append(argx4)
        
        newlist = newlist + arglist  
        
        session = Popen(newlist,stdin=PIPE, stdout=PIPE, stderr=PIPE)
        
        #Query execution timeout 3 minutes
        try:
            (stdout,stderr) = session.communicate(timeout=180)
        except subprocess.TimeoutExpired:
            #process.kill()
            #stdout=stderr
            stderr ="Error - Timeout Expired"
            dbstring=""
            argx3=""
            newlist=[]
             
        # append css style format into output file    
        path=os.path.dirname(sqlqueryfile)
        stylestaticfile=path+"/generic-db-style.html"
         
        if  os.path.exists(stylestaticfile):
            f0=open(stylestaticfile)
            for line in f0.readlines():
                print(line,file=f)
            f0.close()
        else:
            print("Recommendation: for well formatted output, kindly copy generic-db-style.html to query file dir...\n",file=f)    
        if argx3 == "":
            stdout_lines = stderr
            print(stdout_lines,file=f)
        else:
            stdout_lines = stdout.splitlines()
            for line in stdout_lines:
                print(line.decode('utf-8'),file=f)
        f.close()
        return 

# logout view
def logoutview(request):
    global gusername,gpassword,gconnectdb
    gusername=""
    gpassword=""
    gconnectdb=""
    connectdb="" 
    username=""
    message = "Successfully Loggedout "
    return render(request, 'dbawebmenu/loggedout.html', {"message": message})    

# Validate database authentication
def db_conn_user_check(username=None,password=None,tns_name=None):
   conn_string = " %s/%s@%s "% (username,password,tns_name)
   sql_file = "db_conn_check_apps"
   session = Popen(['sqlplus','-L', conn_string, '@'+sql_file ],stdin=PIPE, stdout=PIPE, stderr=PIPE)
   try:
      (stdout,stderr) = session.communicate(timeout=30)
   except subprocess.TimeoutExpired:
      conn_string=""
      password=""
      return -1
   stdout_lines = stdout.splitlines()
   flg=0
   for line in stdout_lines:
       str = (line.decode('utf-8'))
       if ((str.find('ORA-01017')) == 0):
          flg=-1
   return flg


def loginview(request):
   global gusername,gpassword,gconnectdb 
   message=""
   if request.method == "POST":
      
      #Get the posted form
      MyLoginForm = LoginViewForm(request.POST)
    
      if MyLoginForm.is_valid():
         username = MyLoginForm.cleaned_data['username']
         connectdb = MyLoginForm.cleaned_data['connectdb']
         dbpassword = MyLoginForm.cleaned_data["password"]
          
         # returns 1 if user exist
         check_user_exist=Dbaloginuser.objects.filter(db_user_id=username).filter(user_status='A').count()
         
         if check_user_exist == 1:
               # check database level access and return 0 if validation succeed
               db_conn_check_flag = db_conn_user_check(username,dbpassword,connectdb) 
               if (db_conn_check_flag != 0):
                   message = 'Unable to proceed - Invalid user/password/db connection' 
         else:
               message = 'You are not authorized to Login ' + str(check_user_exist)
               return render(request, 'dbawebmenu/loggedout.html', {"connectdb" : connectdb, "username" : username, "message" : message})   
         # only if user db authentication succeed
         gusername = username
         gpassword = dbpassword
         gconnectdb = connectdb 
      else:
          username=""
          connectdb=""
          gusername=""
          gpassword=""
          gconnectdb =""
          message = 'Form Validation Failed'
   else:
      MyLoginForm = LoginViewForm()
    
   if message != "" :
        return render(request, 'dbawebmenu/loggedout.html', {"connectdb" : connectdb, "username" : username, "message": message})   
   else:
        num_dbamenus=Dbamenu.objects.count() 
        num_visits=request.session.get('num_visits', 0)
        request.session['num_visits'] = num_visits+1
        return render(request, 'index.html',context= {'connectdb' : connectdb, 'username' : username,'num_visits':num_visits,'num_dbamenus':num_dbamenus})		
