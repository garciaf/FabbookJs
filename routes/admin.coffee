# Admin Controler to add new article

db = require("../db")
form = require("../form/article")

exports.listArticle = (req, res ) ->
  db.Article.findAll().success (articles) ->
    res.render "admin/listArticle",
      articles: articles
      title: 'blog'

exports.newArticle = (req, res ) ->
  res.render "admin/newArticle",
    form: form.ArticleForm.toHTML()
    title: 'admin'

exports.editArticle = (req, res ) ->
  id = parseInt(req.params.id)
  db.Article.find(id).success (blog) ->
    formEdit = form.ArticleForm.bind(blog.values)
    res.render "admin/editArticle",
      form: formEdit.toHTML()
      title: "edit "+blog.title

exports.updateArticle = (req, res ) ->
  form.ArticleForm.handle req,
    success: (form) ->
      id = parseInt(req.params.id)
      db.Article.find(
        id
        ).success (article) ->
          article.updateAttributes(
            form.data
          ).success () ->
            req.method = 'get'
            res.redirect '/admin/article/list'
    other: (form) ->
      res.render "admin/newArticle",
        form: form.toHTML()
        title: 'failed'
        
exports.deleteArticle = (req, res ) ->
  id = parseInt(req.params.id)
  db.Article.find(id).success (blog) ->
    blog.destroy().success ->
      req.method = 'get'
      res.redirect '/admin/article/list'
 
exports.createArticle = (req, res ) ->
  form.ArticleForm.handle req,
    success: (form) ->
      db.Article.create(
        form.data
      ).success (article) ->
          req.method = 'get'
          res.redirect '/admin/article/list'
    other: (form) ->
      res.render "admin/newArticle",
        form: form.toHTML()
        title: 'failed'
