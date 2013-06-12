chai = require 'chai'
should = chai.should()

cell = require '../lib/cell'

describe 'a cell', ->
  c1 = cell()
  it 'should initially be undefined', -> should.not.exist c1()
  it 'should accept a string', -> c1 'hello'
  it 'should now return the string', -> c1().should.equal 'hello'
  it 'should accept a different string', -> c1 'hello2'
  it 'should now return the new string', -> c1().should.equal 'hello2'
  it 'should return undefined when set', ->
    # this is an important behaviour
    # setting a value that modifies state should not
    # yield any side effects. Only reading allows us to
    # 'see' if something happened
    res = c1 'foo'
    should.not.exist res

  it 'should be a function with an argument list of 1', ->
    c1.should.have.length 1

  it 'should return a view-only version with an argument list of 0', ->
    # this is how we distinguish between R/RW functions
    # ( By inspecting function.length )
    read_only_c1 = c1.view()
    read_only_c1.length.should.equal 0 

  it 'should accept an error', ->
    err = new Error 'abc'
    c1 err # passing error
  it 'and throw it...', -> c1.should.throw 'abc'
  it 'and throw it again', -> c1.should.throw 'abc'