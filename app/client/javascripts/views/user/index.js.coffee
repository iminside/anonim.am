Nali.View.extend UserIndex:

  layout: -> @my.viewInterface()

  helpers:
    stylize: ->
      if @getOf @my.contacts, 'length'
        @Application.setTitle 'Диалоги'
        'show_select'
      else
        @Application.setTitle 'Поиск'
        'show_search_' + if @getMy 'search' then 'on' else 'off'

    ending: ->
      c = @my.contacts.length
      [ 'ов', '', 'а', 'а', 'а' ][ if ( c % 100 > 4 and c % 100 < 20) then 0 else if c % 10 < 5 then c % 10 else 0 ]

  onShow: ->
    @_( 'a.face' ).addClass 'button_active'
    @my.activateSearch() if @my.contacts.length is 0

  onHide: ->
    @_( 'a.face' ).removeClass 'button_active'
