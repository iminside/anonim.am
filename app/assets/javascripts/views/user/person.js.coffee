Nali.View.extend UserPerson:
  
  layout: -> 
    @my.view 'interface'
        
  onShow: ->
    @Application.setTitle 'Образ'
    @subscribeTo @my, 'update.name', @onNameUpdated
    @_( 'a.face' ).addClass 'button_hover'
    @element.niceScroll
      cursoropacitymax: 0.5
      cursorwidth: 5
      zindex: 999
        
  onHide: ->
    @_( 'a.face' ).removeClass 'button_hover'
    @element.getNiceScroll().remove()
    
  onNameUpdated: ->
   ( form = @element.find( 'form' ) ).animate opacity: 0.1, => form.animate opacity: 1