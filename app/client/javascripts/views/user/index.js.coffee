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
      count = @my.contacts.length + ''
      end = parseInt count[ count.length - 1 ]
      if end in [ 2..4 ] then 'а'
      else if end > 4 then 'ов'
      else ''

  onShow: ->
    @_( 'a.face' ).addClass 'button_hover'
    @my.activateSearch() if @my.contacts.length is 0

  onHide: ->
    @_( 'a.face' ).removeClass 'button_hover'
