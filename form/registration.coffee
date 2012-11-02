forms = require "forms"
fields = forms.fields
validators = forms.validators
widgets = forms.widgets
  
registrationForm = forms.create(
  username: fields.string(required: true)
  email: fields.string(required: false)
  password: fields.password(required: true)
)
  
RegistrationForm = exports.RegistrationForm = registrationForm
