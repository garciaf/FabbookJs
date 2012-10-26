###
Module dependencies.
###
express = require 'express'
routes = require './routes'
http = require 'http'
path = require 'path'
Sequelize = require 'sequelize'
config = require "./config/#{process.env.NODE_ENV || 'dev'}.json"

app = express()
app.models = {}
app.connections = {}

app.connections[config.database] = new Sequelize config.database, config.user, config.password,
  logging: true
#Models
app.models.Article = Article = app.connections['fabbook'].import "#{__dirname}/models/article.js"

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
app.get "/news", routes.news

#Create the server
http.createServer(app).listen app.get("port"), ->
  console.log "Express server listening on port " + app.get("port")
