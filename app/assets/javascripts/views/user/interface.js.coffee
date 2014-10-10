Nali.View.extend UserInterface:
  
  helpers:
    search: ->
      if @my.search then 'button_hover' else ''
  
  onShow: ->
    @contactsBox = @element.find '.contacts .ContactsIndexRelation' 
    @contactsBox.niceScroll
      horizrailenabled: false
      railalign: 'left'
      cursoropacitymax: 0.5
      cursorwidth: 5
      zindex: 999
      
  onHide: ->
    @contactsBox.getNiceScroll().remove()
    delete @contactsBox