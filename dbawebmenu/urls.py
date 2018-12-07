from django.urls import path
from . import views


from django.views.generic import TemplateView

urlpatterns = [
    path('loginpage', views.loginpage, name='loginconsole'),
    path('homepage', views.index0, name='home'),
    
	path('', views.index0, name='index'), 
    path('login/',views.loginview,name='login-view'),
    path('logout/',views.logoutview,name='logout-view'),
    path('logfilelist/',views.viewlogfilenames,name='viewlogfile-names'),
    path('dbamenus/', views.DbamenuListView.as_view(), name='dbamenus'),
    path('dbamenu/<int:pk>', views.DbamenuDetailView.as_view(), name='dbamenu-detail'),
    path('dbamenu/sample', views.Dbamenuviewsample, name='dbamenu-viewsample'),   # recent
    path('dbamenu/', views.dbamenuviewreport, name='dbamenu-viewreport'),
    path('awrsnapid/', views.dbamenugetawrsnapid, name='dbamenu-awrsnapdetail'),
    path('instget/', views.dbamenugetinst, name='dbamenu-getinst'),
    path('i34snap/', views.dbamenu34snapdetail, name='dbamenu-34snap'),
    path('i34wtcls/', views.dbamenu34waitclassdetail, name='dbamenu-34waitclass'),
    path('i34wtevt/', views.dbamenu34waiteventdetail, name='dbamenu-34waitevent'),
    path('i34wtsql/', views.dbamenu34waiteventsqldetail, name='dbamenu-34waitsqlevent'),
    path('i34wtqryexplan/', views.dbamenu34sqlplan, name='dbamenu-34xplan'),
	
	]