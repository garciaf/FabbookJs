#
# * GET home page.
# 
form = require("../form/login")
auth = require("../auth")

exports.login = (req, res) ->
  res.render "admin/login",
    form: form.LoginForm.toHTML()
    title: 'login'

exports.authenticate =  auth.Passport.authenticate("local",
  successRedirect: '/admin/article/list'
  failureRedirect: '/login'
)

exports.logout = (req, res) ->
  req.logout()
  res.redirect '/'

