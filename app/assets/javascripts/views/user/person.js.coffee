Nali.View.extend UserPerson:
  
  layout: -> @my.view 'settings'
        
  onShow: ->
    @Application.setTitle 'Образ'
    @_( '#settingsBar' ).addClass 'active_2'
    @element.closest( '.yield' )[0].scrollTop = 0
        
  onHide: ->
    @_( '#settingsBar' ).removeClass 'active_2'
