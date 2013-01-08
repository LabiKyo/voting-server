require! {
  './support'
  './shared'
}
describe 'API server', ->
  describe 'GET /', (...) ->
    before (done) ->
      support.get '/', (err, res, b) ~>
        if err
          throw err
        else
          @response = res
          @body = b
        done!

    shared.request-ok!

    it 'should return message "The polling API server is running!"', ->
      @body.should.have.property 'message'
      @body.message.should.equal 'The polling API server is running!'
