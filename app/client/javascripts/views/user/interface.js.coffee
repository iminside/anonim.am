Nali.View.extend UserInterface:

  helpers:
    search: ->
      if @my.search then 'button_hover' else ''

  onShow: ->
    @element.find( '.contactsWrapper' ).niceScroll railalign: 'left'
    @subscribeTo @my, 'update.color', @changeFavicon
    @changeFavicon()

  onHide: ->
    @element.find( '.contactsWrapper' ).getNiceScroll().remove()

  changeFavicon: ->
    @_( '#favicon' ).replaceWith(
      '<link id="favicon" rel="shortcut icon" href="/images/favicons/' + @my.color + '.ico" type="image/x-icon">'
    )
