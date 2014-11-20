Nali.View.extend UserSounds:

  layout: -> @my.viewSettings()

  onShow: ->
    @Application.setTitle 'Звуки'
    @activateRadio()
    @subscribeTo @my, 'update.sound', @activateRadio
    @layout().activeTab '.sounds'

  activateRadio: ->
    @element.find( '.checked' ) .removeClass 'checked'
    @element.find( 'input:radio:checked' ).parent().addClass 'checked'
