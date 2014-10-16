Nali.View.extend UserPerson:
  
  layout: -> 
    @my.view 'interface'
        
  onShow: ->
    @Application.setTitle 'Образ'
    @_( 'a.face' ).addClass 'button_hover'
    @element.find( '.scrollbar' ).scrollbar()
        
  onHide: ->
    console.log @
    @_( 'a.face' ).removeClass 'button_hover'