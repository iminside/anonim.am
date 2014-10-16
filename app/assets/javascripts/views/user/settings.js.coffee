Nali.View.extend UserSettings:
  
  layout: -> 
    @my.view 'interface'
    
  helpers:
    one: ->
      if @my.who is 'woman' then 'одну' else 'одного'
        
  onShow: ->
    @Application.setTitle 'Настройки'
    @_( 'a.settings' ).addClass 'button_hover'
    @activateRadio()
    @subscribeTo @my, 'update.how', @activateRadio
    @subscribeTo @my, 'update.who', @activateRadio
    @element.niceScroll
      cursoropacitymax: 0.5
      cursorwidth: 5
      zindex: 999
        
  onHide: ->
    @_( 'a.settings' ).removeClass 'button_hover'
    @element.getNiceScroll().remove()
    
  activateRadio: ->
    @element.find( '.radio_active' ) .removeClass 'radio_active' 
    @element.find( 'input:radio:checked' ).parent().addClass 'radio_active' 