Nali.View.extend UserInterface:

  onShow: ->
    ( @contactsBox ?= @element.find '.contactsWrapper' ).niceScroll railalign: 'left'
    @subscribeTo @my, 'update.color', @changeFavicon
    @changeFavicon()

  onHide: ->
    @contactsBox.getNiceScroll().remove()
    @changeFavicon 'black'

  changeFavicon: ( color = @my.color ) ->
    @_( '#favicon' ).replaceWith(
      '<link id="favicon" rel="shortcut icon" href="/images/favicons/' + color + '.ico" type="image/x-icon">'
    )
