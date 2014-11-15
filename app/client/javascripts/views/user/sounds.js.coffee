Nali.View.extend UserSounds:

  layout: -> @my.view 'settings'

  onShow: ->
    @Application.setTitle 'Звуки'
    @activateRadio()
    @subscribeTo @my, 'update.sound', @activateRadio
    @element.closest( '.yield' )[0].scrollTop = 0
    @_( '#settingsBar' ).addClass 'active_3'

  onHide: ->
    @_( '#settingsBar' ).removeClass 'active_3'

  activateRadio: ->
    @element.find( '.checked' ) .removeClass 'checked'
    @element.find( 'input:radio:checked' ).parent().addClass 'checked'
