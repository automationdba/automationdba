from django.contrib import admin

# Register your models here.

from .models import Dbamenu,Dbaloginuser

@admin.register(Dbaloginuser)
class Dbaloginuser(admin.ModelAdmin):
    """
    Administration object for Dbalogin user models. 
    Defines:
     - fields to be displayed in list view (list_display)
      
    """
    list_display = ('db_user_id', 'user_email', 'username','user_type','user_status','last_updated','comments')
    fields = ['db_user_id', 'user_email', 'username','user_type','user_status','last_updated','comments']
   
 
@admin.register(Dbamenu)
class DbamenuAdmin(admin.ModelAdmin):
    """
    Administration object for Dbamenu models. 
    Defines:
     - fields to be displayed in list view (list_display)
      
    """
    list_display = ('task_number', 'task_name', 'task_summary','task_sqlquery')
    fields = ['task_number', 'task_name', 'task_summary','task_sqlquery']
