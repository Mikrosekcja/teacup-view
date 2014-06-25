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

  it "can load components from directory", ->
    view = new View
      components: __dirname + "/components"
      ->
        @p "Teacup View is a great tool!"
        @foot
          author  : "Tadeusz Łazurski",
          project : "Teacup View"
          license : "GPL 3"

    view().should.eql "<p>Teacup View is a great tool!</p><footer><p>&copy; Tadeusz Łazurski. Teacup View is proudly open source (GPL 3)</p></footer>"


  it "can load components ahead of time", ->
    # This is preferred way since v. 0.2.0
    View.load_components
      awesome: (what) ->
        @h1 "#{what} is awesome!"

    view = new View ->
      @awesome "Teacup View"
      @p "That's right."

    view().should.eql "<h1>Teacup View is awesome!</h1><p>That's right.</p>"
