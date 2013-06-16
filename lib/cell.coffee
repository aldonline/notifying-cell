notifying = require 'notifying'

class ReadOnlyError extends Error
class TooManyArgumentsError extends Error

module.exports = cell = ->
  # will hold value
  value = undefined
  # lazy. will eventually hold an array
  notifiers = undefined
  # the cell function that will be returned
  # ( closes over the above variables )
  f = ( new_value ) ->
    a = arguments
    if a.length is 0 # GET
      # register invalidator
      if notifying.active() then ( notifiers ?= [] ).push notifying()
      # return/throw value
      if value instanceof Error then throw value else value
    else if a.length is 1 # SET
      new_value = a[0]
      # check for strict equality
      unless value is new_value
        # store value
        value = new_value
        # call all accumulated notifiers
        if ( notifiers_ = notifiers )?
          notifiers = undefined # reset
          cb() for cb in notifiers_
        # setting a value does not return anything
        # this is part of the cell spec
      undefined
    else
      throw new TooManyArgumentsError
  # a view does not take parameters and will throw an error
  f.view = -> ->
    if arguments.length > 0
      throw new ReadOnlyError
    f()
  f.value = -> value
  f

cell.ReadOnlyError = ReadOnlyError
cell.TooManyArgumentsError = TooManyArgumentsError