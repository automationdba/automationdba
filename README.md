 
++++++++++++++++++
Application name 
+++++++++++++++++
	Dbawebmenu
	
++++++++++++++
Project Title
++++++++++++++

    Collection of Oracle database sql script which can be executed thru Dbawebmenu application.

+++++++++++++++++	
Getting Started
+++++++++++++++++
	Here is the installaiton steps.	
	
	1)copy the source code
		    select base directory/folder
			git clone https://github.com/automationdba/automationdba.git
	2)Install Python 3.6.3 and above version from https://www.python.org/downloads/
    3)Create virtual environment
			pip3 install virtualenv
			virtualenv <env_name>
	4)Activate virtual environment
		 <env_name>/scripts/activate  or source <env_name>/scripts/activate
	5)UnInstall existing packages 
		pip3 uninstall dj-database-url Django django-globals django-mysql gunicorn psycopg2 pytz whitenoise
	6)Install required packages
		pip3 install dj-database-url==0.4.2  Django==2.0.2 django-globals==0.3.2  gunicorn=19.7.1 psycopg2==2.7.3.2 pytz==2018.7 whitenoise==3.3.1
	7)Validate installed packages
		pip3 list
    8)Create super user
       python manage.py createsuperuser 	
	9) Run the application
	   Go to the base directory of cloned repository as per the step 1
	   go to automationdba folder
		run the application by executing below command 
			python manage.py runserver 
	10)Access the application url locally from internet browser
		  http://127.0.0.1:8000/
	11)Install Oracle instant client. For installation, kindly check  https://www.oracle.com/technetwork/database/database-technologies/instant-client/overview/index.html
    12)check remote Oracle db connection   tnsping <remote_db_name>
	13) Add database user details in application
		Go to http://127.0.0.1:8000/admin and add userid,email,username,status entry in dbaloginuser table. Ensure that userid and database user should be same. 
		
++++++++++++++++++    		 
Running the tests
++++++++++++++++++

    1) Click the login link (http://127.0.0.1:8000/loginpage) 
	2) provide your database credentials include database connect string, db userid and db password.
	3) After successfully login, go to DBA Menu task(http://127.0.0.1:8000/dbamenus/). 
	4) There are more than 40 different Oracle database related task exist. Select the desired task.
	5) Input DB Connect string as Oracle database tns connection string
	6) Follow the other input and click Run Option.
	7) SQL query based html report generates in new window.
	8) There are almost 50+ various report can be generated thru this application. Such report helps during identify the Database related performance issues.

+++++++++++++++++++++++++++++++++++++++++++++++++	
Scenario based installation and running the task
+++++++++++++++++++++++++++++++++++++++++++++++++
 

Question - I would like to install dbawebmenu application in windows folder c:\oracle. As per the installation task , I have already downloaded python version 3.6.3 and installed at c:\python\python36 directory. Also, Oracle database name as ora12c remotely accessible with command sqlplus loadtest/loadtest@ora12c from c:\oracle folder. Moroever, loadtest database user already having DBA privileges.
Now, I would like to generate awr report for analysis of performance tuning issues. Could you please help me to extract report from this dbawebmenu application ?

Answer - You need to follow below steps to generate awr report from dbawebmenu application.

Open Command Prompt(Admin) and execute below command
	cd c:\oracle
	c:\python\python36\Scripts\pip3 install virtualenv
	virtualenv c:\oracle\venv
	cd c:\oracle\venv\Scripts
	activate
	(venv) cd c:\oracle
	pip3 uninstall dj-database-url Django django-globals django-mysql gunicorn psycopg2 pytz whitenoise
	pip3 install dj-database-url==0.4.2  Django==2.0.2 django-globals==0.3.2  gunicorn=19.7.1 psycopg2==2.7.3.2 pytz==2018.7 whitenoise==3.3.1
	pip3 list
	git clone https://github.com/automationdba/automationdba.git c:\oracle\
	cd c:\oracle\automationdba
	python manage.py createsuperuser and provide admin username, password and email address. 
	python manage.py runserver
Go to  admin page http://127.0.0.1:8000/admin and add same database user in dbaloginuser table. in this case, userid  as loadtest should be entered in this table. Addd additonal details like email,username,user status as "Active" and comments. 
Go to http://127.0.0.1:8000 which is home page.
Click on Login(Left side panel) or http://127.0.0.1:8000/loginpage
Provie input as ora12c as Database tns, loadtest as Database Login user id and loadtest as Login Password and click Login button.
Now, go to the DBA Menu task(Left side panel) or http://127.0.0.1:8000/dbamenus/
Click 27. Awr report for single/multi snap comparison  or http://127.0.0.1:8000/dbamenu/27
input as ora12c againt DB Connect String, for Single Instance Snap choose AWR -Single Snap , enter instance id as  1 for single instance. 
Also, enter start snap id and end snap id if you know else click awrsnapid button to get required start and end snap details and finally click to Run button.
After few seconds, awr report will be generated in new tab/window.

==================================================================================================================================================

Question - I am production DBA and required to connect multiple database frequently. As per DBAMenu application, I already logged in as user loadtest for the database ORA12C. Now, if I want 
to check tablespace utilization report for other database say ORCL then how I can proceed ?

Answer - if you already connected with diff database(here ORA12C) then if your userid and password same for other database(here ORCL) then no need to login again. You can directlry go to the option 33
and provide DB Connect String as ORCL and input required tablespace name and click Run button. Tablespace utilization report will be generated in new tab/window. But in case userid and password not same 
both databases (ORCL and ORA12c) then you need to logout first from ORA12C and login again to ORCL with userid,password and then go to the option 33.


==================================================================================================================================================

Question - For my daily task, I used to connect different databae with same DBA Account whose userid and password same for all the databases. So, every time I need to logout and login back to the required database or I can directly select different database name againt DB Conn String and generate the report ?

Answer - Most of the cases, we generally have deicated user account for performing DBA task. Database username mostly same for all the databaes which we support/access. Also, assume that userid and password same for most of the databases. In this scenario, no need to logout and login frequently but only change db Connect String to get expected report. 


==================================================================================================================================================

Question - I am not able to login with my credentials in this applicaiton but able to connect sqlplus with userid/password. 

Answer - Probabaly,your userid not added in dbamenu application. First admin need to http://127.0.0.1:8000/admin/  login and add details in table dbaloginuser then only you can able to generate the report. Also, status field of dbaloginuser table should be "Active".


==================================================================================================================================================

Question - Can you explain how two layer of authorization works in ths application ?

Answer - First level of authorization - User should be exist in dbaloginuser table and Second level of authorization - same User should be exist in database which need to connect.


==================================================================================================================================================


