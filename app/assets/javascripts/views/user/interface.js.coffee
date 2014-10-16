Nali.View.extend UserInterface:
  
  helpers:
    search: ->
      if @my.search then 'button_hover' else ''
  
  onShow: ->
    @element.find( '.ContactsIndexRelation' ).scrollator custom_class: 'scrollator_left'