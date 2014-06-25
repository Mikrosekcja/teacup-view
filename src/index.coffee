teacup    = require "teacup"
fs        = require "fs"
path      = require "path"
_         = require "lodash"
_.string  = require "underscore.string"

###
# ::load_components

A helper allowing to load component ahead of time
This way you can load them once (e.g. at app initialization)
and use later.

`options.components` can be

  * a hash of functions
  * or a string designating directory where components are.

In later case each .coffee or .js file will be required and added to teacup.

Use it like this:

    # app.coffee - starting point

    View = require "teacup-view"
    View.load_components __dirname + '/view/components/'
    # ...

    # index.coffee - example view
    View = require "teacup-view"
    module.exports = new View ->
      @coolComponent "Hello, World!"

###
load_components = (components) ->
  switch typeof components
    when "object"
      for name, component of components when typeof component is "function"
        teacup[name] = component.bind teacup

    when "string"
      files   = fs.readdirSync components
      for file in files
        match = file.match /^(.+)\.(js|coffee)$/i
        if match
          name          = _.string.camelize match[1]
          component     = require path.resolve components, match[1]

          teacup[name]  = component

module.exports = (options, template) ->
  if not template and typeof options is "function"
    template  = options
    options   = {}

  # For backward compatibility
  load_components options.components

  # Returns rendered HTML string
  return teacup.renderable template.bind teacup

module.exports.load_components = load_components
