Nali.View.extend ContactIndex: 
  
  events: 'removeDialog on click at .last i:nth-child(2)'
  
  helpers:
      
    online: ->
      if @getOf @my.contact.user, 'online' then @getOf( @my.contact.user, 'color' ) + '_contact' else ''
        
  removeDialog: ( event ) ->
    @my.removeDialog()
    event.preventDefault()
    event.stopPropagation()