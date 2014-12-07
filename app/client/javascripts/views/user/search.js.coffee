Nali.View.extend UserSearch:

  layout: -> @my.viewSettings()

  helpers:
    one: ->
      if @getMy( 'who' ) is 'woman' then 'одну' else 'одного'

  onShow:  ->
    @Application.setTitle 'Поиск'
    @activateRadio()
    @subscribeTo @my, 'update.how', @activateRadio
    @subscribeTo @my, 'update.who', @activateRadio
    @layout().activeTab '.search'

  activateRadio: ->
    @element.find( '.radio_active' ) .removeClass 'radio_active'
    @element.find( 'input:radio:checked' ).parent().addClass 'radio_active'
