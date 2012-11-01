#
# * GET home page.
# 
db = require("../db")

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
  db.Article.find(id).success (article) ->
    if article
      res.render "article",
        article: article
        title: article.title
    else
      res.send 404, "Sorry, we cannot find that!"
