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

  play: ( { sound } ) ->
    if @Audio.supported then @Audio.play sound
    else @Notice.error 'Извините, но ваш браузер не поддерживает воспроизведение звука'
