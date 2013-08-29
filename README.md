reactive-cell
=============

To understand what a reactive cell is you need to understand two different things: Cells and Reactivity.

# cells

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


