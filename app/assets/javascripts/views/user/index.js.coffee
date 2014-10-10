Nali.View.extend UserIndex:
  
  layout: -> 
    @my.view 'interface'
        
  helpers: 
    stylize: ->
      if @getOf @my.contacts, 'length'
        @Application.setTitle 'Диалоги'
        'show_select'
      else 
        @Application.setTitle 'Поиск'
        'show_search_' + if @my.search then 'on' else 'off'
          
  onShow: ->
    @my.activateSearch() if @my.contacts.length is 0
          