###
Module dependencies.
###
express = require 'express'
routes = require './routes'
admin= require './routes/admin'
http = require 'http'
path = require 'path'
app = express()

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
  app.use app.router
  app.use express.static(path.join(__dirname, "public"))

app.configure "development", ->
  app.use express.errorHandler()

# Routing rules
app.get "/", routes.index

app.get "/hello/:name", routes.hello

app.get "/news/:id/article", routes.show

app.get "/news", routes.news

app.get "/admin/article/new", admin.newArticle

app.get "/admin/article/list", admin.listArticle

app.post "/admin/article/new", admin.createArticle

app.get "/admin/article/:id/edit", admin.editArticle

app.post "/admin/article/:id/edit", admin.updateArticle

app.get "/admin/article/:id/delete", admin.deleteArticle

#Create the server
http.createServer(app).listen app.get("port"), ->
  console.log "Express server listening on port " + app.get("port")
