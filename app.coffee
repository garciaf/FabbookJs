findById = (id, fn) ->
  idx = id - 1
  if users[idx]
    fn null, users[idx]
  else
    fn new Error("User " + id + " does not exist")
findByUsername = (username, fn) ->
  i = 0
  len = users.length

  while i < len
    user = users[i]
    return fn(null, user)  if user.username is username
    i++
  fn null, null

# asynchronous verification, for effect...

# configure Express
ensureAuthenticated = (req, res, next) ->
  return next()  if req.isAuthenticated()
  res.redirect "/login"


###
Module dependencies.
###
express = require 'express'
passport = require 'passport'
flash = require 'connect-flash'
routes = require './routes'
admin= require './routes/admin'
security= require './routes/security'
http = require 'http'
path = require 'path'
app = express()
util = require("util")
LocalStrategy = require("passport-local").Strategy
users = [
  id: 1
  username: "bob"
  password: "secret"
  email: "bob@example.com"
,
  id: 2
  username: "joe"
  password: "birthday"
  email: "joe@example.com"
]
passport.serializeUser (user, done) ->
  done null, user.id

passport.deserializeUser (id, done) ->
  findById id, (err, user) ->
    done err, user


passport.use new LocalStrategy((username, password, done) ->
  process.nextTick ->
    findByUsername username, (err, user) ->
      return done(err)  if err
      unless user
        return done(null, false,
          message: "Unknown user " + username
        )
      unless user.password is password
        return done(null, false,
          message: "Invalid password"
        )
      done null, user


)

app.configure ->
  app.set "port", process.env.PORT or 3000
  app.set "views", __dirname + "/views"
  app.set "view engine", "jade"
  app.use express.favicon()
  app.use express.logger("dev")
  app.use express.bodyParser()
  app.use express.methodOverride()
  app.use express.cookieParser("your secret here")
  app.use express.session()
  app.use passport.initialize()
  app.use passport.session(secret: "keyboard cat")
  app.use flash()
  app.use passport.initialize()
  app.use passport.session()
  app.use app.router
  app.use express.static(path.join(__dirname, "public"))

app.configure "development", ->
  app.use express.errorHandler()

# Routing rules
app.get "/", routes.news

app.get "/hello/:name", routes.hello

app.get "/news/:id/article", routes.show

app.get "/login", security.login

app.post "/login", security.authenticate, admin.listArticle

app.get "/logout", security.logout

app.get "/admin/article/new", admin.newArticle

app.get "/admin/article/list", ensureAuthenticated ,admin.listArticle

app.post "/admin/article/new", admin.createArticle

app.get "/admin/article/:id/edit", admin.editArticle

app.post "/admin/article/:id/edit", admin.updateArticle

app.get "/admin/article/:id/delete", admin.deleteArticle


#Create the server
http.createServer(app).listen app.get("port"), ->
  console.log "Express server listening on port " + app.get("port")
