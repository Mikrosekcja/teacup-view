View = require "../../"

module.exports = (attributes) ->
  @footer ->
    {
      author
      project
      license
    } = attributes
    @p -> @raw "&copy; #{author}. #{project} is proudly open source (#{license})"
