assert = require 'assert'
optimize = require '../../lib'

describe 'test optimize object', ->

  it 'should detect an unoptimized object', ->
    object = key:'value'
    delete object.key
    result = optimize.check object
    assert.equal result, false

  it 'should detect an optimized object', ->
    object = key:'value'
    result = optimize.check object
    assert.equal result, true

  it 'should optimize an object', ->
    object = key:'value'

    assert.equal object.key, 'value'
    delete object.key
    assert.equal object.key, undefined

    result = optimize.check object
    assert.equal result, false, 'should be unoptimized before next test'

    optimize object
    assert.equal object.key, undefined

    result = optimize.check object
    assert.equal result, true, 'should return true once optimized'


  it 'does what Object.freeze doesnt', ->
    object = key:'value', key2:'value2'
    delete object.key
    result = optimize.check object
    assert.equal result, false

    # try to
    Object.freeze object
    enforcer = -> object.blah
    enforcer()
    enforcer()
    result = optimize.check object
    assert.equal result, false

  it 'does what Object.seal doesnt', ->
    object = key:'value', key2:'value2'
    delete object.key
    result = optimize.check object
    assert.equal result, false

    Object.seal object
    enforcer = -> object.blah
    enforcer()
    enforcer()
    result = optimize.check object
    assert.equal result, false

  it 'does what Object.create DOES', ->
    object = key:'value', key2:'value2'
    delete object.key
    result = optimize.check object
    assert.equal result, false

    another = Object.create object
    enforcer = -> object.blah
    enforcer()
    enforcer()
    result = optimize.check object
    assert.equal result, true

  it 'does what repeated access doesnt', ->
    object = key:'value', key2:'value2'
    delete object.key
    result = optimize.check object
    assert.equal result, false

    enforcer = -> object.blah
    enforcer()
    enforcer()
    enforcer()
    result = optimize.check object
    assert.equal result, false
