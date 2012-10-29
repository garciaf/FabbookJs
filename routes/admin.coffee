db = require("../db")


exports.create = (req, res ) ->
  forms = require "forms"
  fields = forms.fields
  validators = forms.validators
  widgets = forms.widgets
  
  articleForm = forms.create(
    title: fields.string(required: true)
    content: fields.string(required: true)
  )
  res.render "newArticle",
    form: articleForm.toHTML()
    title: 'admin'
