Nali.View.extend ContactIndex: 
  
  events: 'deleteDialog on click at .last i:nth-child(2)'
  
  helpers:
      
    online: ->
      if @getOf @my.contact.user, 'online' then @getOf( @my.contact.user, 'color' ) + '_contact' else ''
        
  deleteDialog: ( event ) ->
    @my.delete()
    event.preventDefault()
    event.stopPropagation()