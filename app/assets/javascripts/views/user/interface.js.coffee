Nali.View.extend UserInterface:
  
  helpers:
    search: ->
      if @my.search then 'button_hover' else ''
  
  onShow: ->
    @element.find( '.ContactsIndexRelation' ).scrollator custom_class: 'scrollator_left'
    @subscribeTo @my, 'update.color', @changeFavicon
    @changeFavicon()
    
  changeFavicon: ->
    @_( '#favicon' ).replaceWith( 
      '<link id="favicon" rel="shortcut icon" href="/images/favicons/favicon_' + @my.color + '.ico" type="image/x-icon">'
    )