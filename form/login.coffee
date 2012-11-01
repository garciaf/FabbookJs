forms = require "forms"
fields = forms.fields
validators = forms.validators
widgets = forms.widgets
  
loginForm = forms.create(
  username: fields.string(required: true)
  password: fields.password(required: true)
)
  
LoginForm = exports.LoginForm = loginForm
