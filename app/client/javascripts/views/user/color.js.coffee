Nali.View.extend UserColor:

  hideDelay: 200

  insertTo: -> '.UserInterface'

  events: 'hide on click at a'

  onShow: ->
    @element.addClass 'show'
    @_( 'a.colors' ).addClass 'button_hover'
    @_( document ).on 'click.colors', ( event ) =>
      @hide() unless @_( event.target ).closest( 'a.colors, div.UserColor' ).length

  onHide: ->
    @element.removeClass 'show'
    @_( 'a.colors' ).removeClass 'button_hover'
    @_( document ).off 'click.colors'
