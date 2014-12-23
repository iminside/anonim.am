Nali.View.extend ContactIndex:

  events: 'deleteDialog on click at .last i:nth-child(2)'

  helpers:
    online: ->
      if @getOf @my.contact, 'online' then @getOf @my.contact, 'color' else ''

  deleteDialog: ( event ) ->
    @my.showDelete()
    event.preventDefault()
    event.stopPropagation()

  activeModeOn: ->
    @element.addClass 'active'

  activeModeOff: ->
    @element.removeClass 'active'
