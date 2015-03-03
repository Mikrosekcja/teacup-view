# Teacup View

a View class - based on Teacup, extensible via components

It's a ligthweight wrapper on top of [Teacup](http://goodeggs.github.io/teacup/).

## Install

``` bash
npm install teacup-view
```

## Use

``` coffee-script
View = require "teacup-view"

view = new View (name) ->
  @div => # Inside view use fat arrow to keep reference to teacup object
    @h1 "Hello! #{name}"
    @p  "It's nice to see you!"

html = view "Anna"
```

TODO: write better readme with examples.

In the mean time, [see tests](./test/view.coffee).
