forms = require "forms"
fields = forms.fields
validators = forms.validators
widgets = forms.widgets
  
articleForm = forms.create(
  title: fields.string(required: true)
  content: fields.string(
    required: true
    widget: widgets.textarea()
  )
)
  
ArticleForm = exports.ArticleForm = articleForm
