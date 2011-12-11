
express = require('express')
app = express.createServer()

app.use require('connect-assets')({detectChanges: true})
app.set('view engine', 'jade')

app.configure 'development', ->
  app.use(express.errorHandler({ dumpExceptions: true, showStack: true }))

app.use(express.static(__dirname + '/public'));

app.get '/', (req, res, next) ->
  res.render('index.jade')

app.get '/user', (req, res, next) ->
  app.render('')

app.post '/user', (req, res, next) ->
  console.log(req.query);

port = process.env.PORT || 3000;
app.listen port, ->
  console.log("Listening on " + port);