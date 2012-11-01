passport = require 'passport'
util = require 'util'
LocalStrategy = require("passport-local").Strategy

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
  
  # asynchronous verification, for effect...
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

Passport = exports.Passport = passport
