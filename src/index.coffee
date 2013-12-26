teacup    = require "teacup"    
fs        = require "fs"
_         = require "lodash"
_.string  = require "underscore.string"

module.exports = (options, template) ->
  if not template and typeof options is "function" 
    template  = options
    options   = {}

  {
    components
  } = options

  ###
  `options.components` can be 
  
    * a hash of functions 
    * or a string designating directory where components are.

  In later case each .coffee or .js file will be required and added to teacup.
  ###
  
  switch typeof components
    when "object" 
      for name, component in components when typeof component is "function"
        teacup[name] = component.bind teacup

    when "string"
      files   = fs.readdirSync components
      for file in files
        match = file.match /^(.+)\.(js|coffee)$/i
        if match
          name          = _.string.camelize     match[1]
          component     = require components +  match[1]

          teacup[name]  = component

  return teacup.renderable template.bind teacup

