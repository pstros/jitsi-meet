'use strict'

XMPPEvents = require('../../service/xmpp/XMPPEvents')

describe 'xmpp', ->

  sandbox = undefined
  xmpp = undefined
  
  # xmpp global vars
  connection = null
  authenticatedUser = false

  basicXmppProps =
    getConnection: -> connection
    sessionTerminated: false
    Status: Strophe.Status = 'bogus'
    forceMuted: false


  # Mock objects
  MockEventEmitter = mockEventEmitter = undefined
  MockModerator = undefined
  MockRetry = undefined

  beforeEach ->
    sandbox = sinon.sandbox.create()

    class MockEventEmitter
      constructor: ->
        mockEventEmitter = this
      on: sandbox.stub()
      removeListener: sandbox.stub()
      emit: sandbox.stub()

    MockModerator =
      init: sandbox.stub()

    MockRetry =
      operation: sandbox.stub().returns
        attempt: sandbox.stub()

    xmpp = require('../../modules/xmpp/xmpp.js', {
      './moderator': MockModerator
      'events': MockEventEmitter
      'retry': MockRetry
      'pako': ->
      './recording': ->
      './SDP': ->
      '../settings/Settings': ->
      './strophe.emuc': ->
      './strophe.jingle': ->
      './strophe.moderate': ->
      './strophe.util': ->
      './strophe.rayo': ->
      './strophe.logger': ->
    })

  afterEach ->
    sandbox.restore()

  it 'should init basic properties', ->
    xmpp.should.have.deep.property prop for prop of basicXmppProps

  describe 'start', ->
    beforeEach ->
      APP.RTC =
        addStreamListener: ->
        addListener: ->

      config.hosts =
        anonymousdomain: null
        domain: null
        
    it 'should invoke Moderator.init', ->
      xmpp.start()
      MockModerator.init.should.have.been.called
#      Ideally:
#      MockModerator.init.should.have.been.calledWithExactly xmpp, mockEventEmitter

  describe '#createConnection', ->
    it 'should return Strophe connection object', ->
      Strophe.Connection = sandbox.stub()

      config.bosh = undefined
      xmpp.createConnection().should.deep.equal {}
      Strophe.Connection.should.have.been.calledWith '/http-bind'

      config.bosh = 'foo'
      xmpp.createConnection().should.deep.equal {}
      Strophe.Connection.should.have.been.calledWith config.bosh

      
  describe '#getStatusString', ->
    #TODO

  describe '#promptLogin', ->
    it 'should emit proper XMPPEvent', ->
      xmpp.promptLogin()
      mockEventEmitter.emit.should.have.been.calledWithExactly XMPPEvents.PROMPT_FOR_LOGIN
