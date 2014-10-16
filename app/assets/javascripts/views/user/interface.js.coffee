Nali.View.extend UserInterface:
  
  helpers:
    search: ->
      if @my.search then 'button_hover' else ''
  
  onShow: ->
    @element.find( '.contacts .ContactsIndexRelation' ).addClass( 'scrollbar' ).scrollbar()