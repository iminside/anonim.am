Nali.View.extend UserInterface:
  
  helpers:
    search: ->
      if @my.search then 'button_hover' else ''
  
  onShow: ->
    @contactsBox = @element.find '.contacts .ContactsIndexRelation'
    @contactsBox.addClass( 'scrollbar' ).scrollbar()
      
  onHide: ->
    delete @contactsBox