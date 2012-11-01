Sequelize = require 'sequelize'
config = require "./config/#{process.env.NODE_ENV || 'dev'}.json"

connections = {}

connections[config.database] = new Sequelize config.database, config.user, config.password,
  logging: true
#Models
Article = exports.Article = connections[config.database].import "#{__dirname}/models/article.js"
User = exports.User = connections[config.database].import "#{__dirname}/models/user.js"
