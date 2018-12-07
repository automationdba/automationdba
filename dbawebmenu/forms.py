from django.core.exceptions import ValidationError
#from django.utils.translation import ugettext_lazy as _
import datetime #for checking renewal date range.
from django import forms
from .models import Dbamenu

class LoginViewForm(forms.Form):
   connectdb = forms.CharField(max_length=25) 
   username = forms.CharField(max_length = 100)
   password = forms.CharField(widget = forms.PasswordInput())
    
   def clean_message(self):
      connectdb = self.cleaned_data.get("connectdb")
      username = self.cleaned_data.get("username")
      
      if not username:
         raise forms.ValidationError("User does not exist in our db!")
      return connectdb,username

# Login validation check 
class DbamenuInputForm(forms.Form):
    param1 =forms.CharField(help_text="Enter first input")
    param2 =forms.CharField(help_text="Enter second input")
    param3 =forms.DateField(help_text="Enter Date as input")

    def clean_input_date(self):
        data = self.cleaned_data['param3']
        if data < datetime.data.today():
            raise ValidationError(_('Invalid date - input date in past'))
        return data    
