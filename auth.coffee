db = require("./db")
passport = require 'passport'
util = require 'util'
sechash = require 'sechash'

# asynchronous verification, for effect...
ensureAuthenticated = (req, res, next) ->
  return next()  if req.isAuthenticated()
  res.redirect "/login"

findById = (id, fn) ->
  db.User.find(id).success (user) ->
    if user
      fn null, user
    else
      fn new Error("User " + id + " does not exist")

findByUsername = (username, fn) ->
  db.User.find
  db.User.find(where:
    username: username
  ).success (user) ->
    return fn(null, user)

checkPassword = (user, password) ->
  opts =
    algorithm: "sha512"
    salt: user.salt
    includeMeta: false
  return sechash.testHashSync password, user.password, opts

LocalStrategy = require("passport-local").Strategy

passport.serializeUser (user, done) ->
  done null, user.id

passport.deserializeUser (id, done) ->
  findById id, (err, user) ->
    done err, user

passport.use new LocalStrategy((username, password, done) ->
  
  # asynchronous verification, for effect...
  process.nextTick ->
    findByUsername username, (err, user) ->
      return done(err)  if err
      unless user
        return done(null, false,
          message: "Unknown user " + username
        )
#      unless user.password is password
      unless checkPassword user, password
        return done(null, false,
          message: "Invalid password"
        )
      done null, user
)

Passport = exports.Passport = passport
EnsureAuthenticated = exports.EnsureAuthenticated = ensureAuthenticated
