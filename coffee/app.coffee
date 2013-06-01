express  = require 'express'
mongoose = require 'mongoose'
widgets = require './controller/widgets'
creds = require './creds'
auth = require './controller/auth'


allowCrossDomain = (req, res, next) ->
  res.header('Access-Control-Allow-Origin', '*')
  res.header('Access-Control-Allow-Methods', 'GET,PUT,POST,DELETE')
  res.header('Access-Control-Allow-Headers', 'Content-Type, Authorization')
  if ('OPTIONS' == req.method) res.send(200)
  else next()

app = express()

app.configure ->
  app.set "port", process.env.PORT or 4000
  app.set 'storage-uri', creds.mongo.uri
  app.use express.bodyParser()
  app.use express.methodOverride()
#  app.use allowCrossDomain
  app.use express.cookieParser("fiftyfiftycookie")
  app.use express.session
    secret: "fft_sec"
    cookie:
      maxAge: 60000
  app.use auth.passport.initialize()
  app.use auth.passport.session()
  app.use app.router

mongoose.connect app.get('storage-uri'), { db: { safe: true }}, (err) ->
  console.log "Mongoose - connection error: " + err if err?
  console.log "Mongoose - connection OK"
require './model/widget'

app.get '/login', auth.login.get
app.post '/login', auth.login.post() #todo:: why do i have to call post??

app.get '/', auth.ensureAuthenticated, (req, res) ->
  res.send '<a href="/auth">Hello, Scott!</a>'

app.post    '/widgets',     widgets.create
app.get     '/widgets',     widgets.retrieve
app.get     '/widgets/:id', widgets.retrieve
app.put     '/widgets/:id', widgets.update
app.delete  '/widgets/:id', widgets.delete

app.listen app.get('port'), ->
  console.log "Listening on port #{app.get('port')}"
