exports.request-ok = (...) ->
  it 'should return json response', ->
    @response.should.be.json

  it 'should return 200', ->
    @response.should.have.status 200

  it 'should be powered by Voting Server', ->
    @response.should.have.header 'X-Powered-By', 'Voting Server'
