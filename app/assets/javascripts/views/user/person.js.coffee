Nali.View.extend UserPerson:
  
  layout: -> 
    @my.view 'interface'
        
  onShow: ->
    @Application.setTitle 'Образ'
    @_( 'a.face' ).addClass 'button_hover'
    @element.scrollator()
        
  onHide: ->
    @_( 'a.face' ).removeClass 'button_hover'