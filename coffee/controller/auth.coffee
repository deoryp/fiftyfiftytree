fs = require 'fs'
passport = require 'passport'
LocalStrategy = require('passport-local').Strategy

passport.use new LocalStrategy (username, password, done) ->
  if username == 'scott' and password == 'pass'
    return done(null, {id: 1, name: "scott"})
  return done(null, false)

passport.serializeUser (user, done) ->
  done null, user

passport.deserializeUser (obj, done) ->
  done null, obj

exports.initialize = passport.initialize

exports.session = passport.session

exports.passport = passport

exports.ensureAuthenticated = (req, res, next) ->
  if req.isAuthenticated()
    return  next()
  res.redirect '/login'

exports.login =
  get: (req, res) ->
    res.send fs.readFileSync('login.html').toString()

  post: (req, res) ->
    passport.authenticate('local', successRedirect: '/', failureRedirect: '/login')



