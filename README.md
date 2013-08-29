reactive-cell
=============

To understand what a reactive cell is you need to understand two different things: Cells and Reactivity.

# Cells

Cells are simply a convention. They are functions that store a value.

```coffeescript
typeof cell is 'function' # true

# you set a value by passing one argument
cell 'something'

# and get it back by calling the function with no arguments
cell() # 'something'
```

That's it. Ah. One more thing. When setting a value the cell must return `undefined`.

You can build your own cell just by understanding this convention. Here's an example:

```coffeescript

create_cell = ->
  value = null
  (v) ->
    if arguments.length is 1
      value = v
      undefined
    else
      value

# and you now have a valid cell
cell_instance = create_cell()
cell_instance 'something'
cell_instance() # 'something'
```

So. To wrap up. Cells are not a library or a framework. They are simply a *convention*.
They simply follow a contract.

What are they used for?
Well, they provide a simple way of passing read-write values around.
They also play along nicely with Reactivity. Which is what we'll talk about now.

# Reactivity

Note: You can find a more detailed explanation in the [Reactivity](https://github.com/aldoline/reactivity) github page.

Contrary to Cells, which are simply a contract, Reactivity is a library. It allows you to build
and consume reactive functions ( functions that let you know when things change ).

# Reactive Cells

This module is an implementation of the Cell protocol
that uses Reactivity.io under the covers. These cells let you know when their value changes.

```coffeescript
reactivity = require 'reactivity'
rcell      = require 'reactive-cell'

# create a cell
my_cell = rcell()

# subscribe to changes using the reactivity module
reactivity.subscribe my_cell, -> console.log "cell value changed to " + my_cell()

my_cell "Foo"

# this will print "cell value changed to Foo"

my_cell "Bar"

# this will print "cell value changed to Bar"
```

# Next

This is the barebones / minimal implementation of a reactive cell. It simply implements the Cell contract
and uses Reactivity.io under the covers.

For a more advanced cell implementation take a look at [reactive-supercell](https://github.com/aldonline/reactive-supercell).
Super Cells know how to locally persist themselves, apply some type based validations, etc.

Remember: You can create your own Cells. It is just a convention.

