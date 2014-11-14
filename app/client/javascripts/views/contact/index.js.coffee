Nali.View.extend ContactIndex:

  events: 'deleteDialog on click at .last i:nth-child(2)'

  helpers:
    online: ->
      if @getOf @my.contact, 'online' then @getOf( @my.contact, 'color' ) + '_contact' else ''
    userFace: ->
      if ( @getOf @my.contact, 'avatar' )?
        '<span class="avatar" style="background-image: url(' + @my.contact.avatarPath + ')"></span>'
      else
        '<i class="faceicon-' + ( @getOf @my.contact, 'gender' ) + ( @getOf @my.contact, 'image' ) + '"></i>'

  deleteDialog: ( event ) ->
    @my.showDelete()
    event.preventDefault()
    event.stopPropagation()

  activeModeOn: ->
    @element.addClass 'active'

  activeModeOff: ->
    @element.removeClass 'active'
