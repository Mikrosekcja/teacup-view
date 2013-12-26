do (require "source-map-support").install

View  = require "../"

describe "View", ->
  it "can render simple html", ->
    view = new View -> @h1 "Hello!"
    view().should.eql "<h1>Hello!</h1>"