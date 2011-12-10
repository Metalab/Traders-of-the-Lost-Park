
express = require('express')
app = express.createServer()

app.use require('connect-assets')()
app.use(express.errorHandler({ dumpExceptions: true, showStack: true }))
app.set('view engine', 'jade')

app.configure 'development', ->
  app.use(express.static(__dirname + '/public'));
  app.use(express.compiler({ src: __dirname + '/public', enable: ['less'] }));

app.configure 'production', ->
  app.use(express.static(__dirname + '/public', { maxAge: 31557600000 }));
  app.use(express.errorHandler());

app.get '/', (req, res, next) ->
  res.render('index.jade')

app.get '/user', (req, res, next) ->
  app.render('')

app.post '/user', (req, res, next) ->
  console.log(req.query);

port = process.env.PORT || 3000;
app.listen port, ->
  console.log("Listening on " + port);