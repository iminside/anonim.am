Nali.View.extend UserSearch:

  layout: -> @my.view 'settings'

  events:  []

  helpers:
    one: ->
      if @my.who is 'woman' then 'одну' else 'одного'

  onShow:  ->
    @Application.setTitle 'Поиск'
    @activateRadio()
    @subscribeTo @my, 'update.how', @activateRadio
    @subscribeTo @my, 'update.who', @activateRadio
    @element.closest( '.yield' )[0].scrollTop = 0
    @_( '#settingsBar' ).addClass 'active_1'

  onHide: ->
    @_( '#settingsBar' ).removeClass 'active_1'

  activateRadio: ->
    @element.find( '.radio_active' ) .removeClass 'radio_active'
    @element.find( 'input:radio:checked' ).parent().addClass 'radio_active'
