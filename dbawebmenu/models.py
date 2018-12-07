from django.db import models

# Create your models here.

from django.urls import reverse #Used to generate urls by reversing the URL patterns
        
import uuid # Required for unique book instances
from datetime import date
from datetime import datetime
from django.contrib.auth.models import User #Required to assign User as a borrower

class Dbaloginuser(models.Model):
    """
    Model representing alllowed login user for accessing dba web menu apps.
    """
    USER_STATUS = (
		  ('A', 'Active'),
		  ('I', 'InActive'),
			)
    db_user_id = models.CharField(max_length=20,primary_key=True,help_text='Enter Database User id')
    user_email = models.EmailField(max_length=200,blank=False)
    username = models.CharField(max_length=100,blank=True,help_text='Enter username')
    user_type = models.CharField(max_length=100,blank=True,help_text='Enter username as monitor,dba,apps')
    user_status = models.CharField(max_length=1,choices=USER_STATUS,default='A',help_text='status A - active, I - Inactive' )  
    last_updated = models.DateTimeField(default=datetime.now,blank=True)
    comments = models.CharField(max_length=200,blank=True,help_text='Enter comments if any')

class Dbamenu(models.Model):
    """
    Model representing an dbamenu.
    """
    task_number = models.IntegerField(primary_key=True,help_text='Enter task number')
    task_name = models.CharField(max_length=100)
    task_summary = models.CharField(max_length=500)
    task_sqlquery = models.TextField() 

    class Meta:
        #ordering = ["task_name"]
        ordering = ["task_number"]
    
    def get_absolute_url(self):
        """
        Returns the url to access a particular dbamenu instance.
        """
        #return reverse('dbamenu-detail', args=[str(self.id)])
        return reverse('dbamenu-detail', args=[str(self.task_number)])
    

    def __str__(self):
        """
        String for representing the Model object.
        """
        #return '{0}'.format(self.task_name)
        return '{0}, {1}'.format(self.task_number,self.task_name)
