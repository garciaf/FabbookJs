#
# * GET home page.
# 
exports.index = (req, res) ->
  res.render "index",
    title: "Fabbook"


exports.hello = (req, res) ->
  name = req.params.name
  res.render "hello",
    name: name
    title: name

exports.news = (req, res ) ->
  app.models.Article.findAll().success (articles) ->
    res.render "articles",
      articles: articles
      title: 'blog'
