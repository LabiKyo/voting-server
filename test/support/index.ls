require! request

self = exports = module.exports =
  server: 'http://localhost:3000'
  req: request.defaults do
    json: true
  get: (url, callback) ~>
    self.req "#{self.server}#url", callback
