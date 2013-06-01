express  = require 'express'
mongoose = require 'mongoose'
widgets = require './controller/widgets'
creds = require './creds'

app = express()

app.configure ->
  app.set 'storage-uri', creds.mongo.uri
  app.use express.bodyParser()

mongoose.connect app.get('storage-uri'), { db: { safe: true }}, (err) ->
  console.log "Mongoose - connection error: " + err if err?
  console.log "Mongoose - connection OK"

require './model/widget'

app.configure ->
  app.set "port", process.env.PORT or 4000

app.get '/', (req, res) ->
  res.send 'Hello, Zaiste!'

app.listen app.get('port'), ->
  console.log "Listening on port #{app.get('port')}"

app.post    '/widgets',     widgets.create
app.get     '/widgets',     widgets.retrieve
app.get     '/widgets/:id', widgets.retrieve
app.put     '/widgets/:id', widgets.update
app.delete  '/widgets/:id', widgets.delete

