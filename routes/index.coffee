#
# * GET home page.
# 
db = require("../db")

exports.index = (req, res) ->
  res.render "index",
    title: "Fabbook"


exports.hello = (req, res) ->
  name = req.params.name
  res.render "hello",
    name: name
    title: name

exports.news = (req, res ) ->
  db.Article.findAll().success (articles) ->
    res.render "articles",
      articles: articles
      title: 'blog'

exports.show = (req, res ) ->
  id = parseInt(req.params.id)
  db.Article.find(id).success (blog) ->
    res.render "article",
      article: blog
      title: blog.title
