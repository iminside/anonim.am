Nali.View.extend UserInterface:

  helpers:
    search: ->
      if @getMy 'search' then 'button_active' else ''

  onShow: ->
    @element.find( '.contactsWrapper' ).niceScroll railalign: 'left'
    @subscribeTo @my, 'update.color', @changeFavicon
    @changeFavicon()

  onHide: ->
    @element.find( '.contactsWrapper' ).getNiceScroll().remove()
    @changeFavicon 'black'

  changeFavicon: ( color = @my.color ) ->
    @_( '#favicon' ).replaceWith(
      '<link id="favicon" rel="shortcut icon" href="/images/favicons/' + color + '.ico" type="image/x-icon">'
    )
