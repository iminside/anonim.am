Nali.View.extend UserSettings:

  layout: ->
    @my.view 'interface'

  onShow: ->
    @Application.setTitle 'Настройки'
    @_( 'a.settings' ).addClass 'button_hover'
    @element.find( '.yield' ).niceScroll railoffset: left: 14

  onHide: ->
    @_( 'a.settings' ).removeClass 'button_hover'
    @element.find( '.yield' ).getNiceScroll().remove()
