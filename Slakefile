require! {
  fs
  child_process
  path
}
# styles
reset = '\x1B[0m'
bold = '\x1B[1m'
red = '\x1B[31m'
green = '\x1B[32m'

# helper
String::style = (style) ->
  "#style#{@to-string!}#reset"

String::to-bold = ->
  @style bold
String::to-green = ->
  @style green
String::to-red = ->
  @style red

# variables
last-server = null # global variable used to shutdown last server

# tasks
task \watch, "Watch file changes and trigger other tasks", ->
  invoke \run
  watch = (dir) ->
    fs.watch dir, ->
      invoke \run
    files = fs.readdir-sync dir
    for file in files when file not in [\node_modules, \.git]
      file-path = path.join dir, file
      stat = fs.stat-sync file-path
      if stat.is-directory!
        watch file-path
  watch '.'

task \run, "Run all tasks", ->
  if last-server?
    last-server.kill!
  invoke \run:server
  invoke \run:test

task \run:server, "Run server in child process", ->
  last-server := server = child_process.spawn \lsc, ['-bd', 'app.ls'],
    stdio: 'inherit'

  server.on 'exit', (code) ->
    unless code is 0
      console.log "[Server exit with code #code]\n\n".to-red!

task \run:test, "Run mocha test", ->
  mocha = child_process.spawn \mocha, [],
    stdio: 'inherit'

# clean up
process.on 'exit', ->
  if last-server?
    last-server.kill!

process.on 'SIGINT', ->
  process.exit 0
