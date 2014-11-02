Nali.View.extend ContactIndex:

  events: 'deleteDialog on click at .last i:nth-child(2)'

  helpers:
    online: ->
      if @getOf @my.contact.user, 'online' then @getOf( @my.contact.user, 'color' ) + '_contact' else ''
    userFace: ->
      if ( @getOf @my.contact.user, 'avatar' )?
        '<span class="avatar" style="background-image: url(' + @my.contact.user.avatarPath + ')"></span>'
      else
        '<i class="faceicon-' + ( @getOf @my.contact.user, 'gender' ) + ( @getOf @my.contact.user, 'image' ) + '"></i>'

  deleteDialog: ( event ) ->
    @my.delete()
    event.preventDefault()
    event.stopPropagation()

  activeModeOn: ->
    @element.addClass 'active'

  activeModeOff: ->
    @element.removeClass 'active'
