Nali.View.extend UserSettings:
  
  layout: -> 
    @my.view 'interface'
    
  helpers:
    one: ->
      if @my.who is 'woman' then 'одну' else 'одного'
        
  events: 'activateRadio on change at .input_radio label input'
        
  onShow: ->
    @Application.setTitle 'Настройки'
    @_( 'a.settings' ).addClass 'button_hover'
    @_( 'input:radio:checked' ).parent().addClass 'radio_active' 
    @element.niceScroll
      cursoropacitymax: 0.5
      cursorwidth: 5
      zindex: 999
        
  onHide: ->
    @_( 'a.settings' ).removeClass 'button_hover'
    @element.getNiceScroll().remove()
    
  activateRadio: ( event ) ->
    @_( event.currentTarget )
      .closest( '.input_radio' )
      .find( '.radio_active' )
      .removeClass( 'radio_active' )
      .end().end().parent()
      .addClass 'radio_active' 