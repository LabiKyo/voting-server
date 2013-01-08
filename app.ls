require! {
  path
  http
  express
  \./route
}

app = express!

app.configure ->
  app.set 'port', process.env.PORT || 3000
  app.set 'views', __dirname + '/view'
  #app.use express.logger 'dev'
  # add X-Powered-By header
  app.use (req, res, next) ->
    res.set 'X-Powered-By', 'Voting Server'
    next null
  app.use express.bodyParser!
  app.use express.methodOverride!
  app.use app.router


app.configure 'development', ->
  app.use express.errorHandler!


app.get '/', route.index

http.createServer app .listen app.get('port'), ->
  console.log "Express server listening on port " + app.get('port')
