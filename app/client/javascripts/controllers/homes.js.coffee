Nali.Controller.extend Homes:

  actions:
    default: 'index'

    index: ->
      @redirect 'user' if @Application.user?
      @collection.freeze().add @Model.Home.new()
