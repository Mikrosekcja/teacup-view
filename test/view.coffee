do (require "source-map-support").install

View  = require "../"

describe "View", ->
  it "can render simple html", ->
    view = new View -> @h1 "Hello!"
    view().should.eql "<h1>Hello!</h1>"

  it "can use components", ->
    view = new View
      components:
        heading   : (title, subtitle) ->
          @header ->
            @h1 title
            @h2 subtitle
      (data) ->
        @body =>
          @heading data.title, data.subtitle
          @p "That was a hell of a title!"

    data =
      title   : "Eye catching!"
      subtitle: "A title designed to draw attention"
    
    view(data).should.eql "<body><header><h1>Eye catching!</h1><h2>A title designed to draw attention</h2></header><p>That was a hell of a title!</p></body>"

