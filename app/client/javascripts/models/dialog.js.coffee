Nali.Model.extend Dialog:

  hasMany: [ 'contacts', 'messages' ]

  beforeShow:
    index: ->
      @loadHistory() unless @messages.length
      @messages.order by: 'created'
      @message = @Message.new dialog_id: @id, user_id: @Application.user.id
      @Application.activeDialog = @
      @contact().activate().view( 'index' ).activeModeOn()

  afterHide:
    index: ->
      @Application.activeDialog = null
      @contact()?.deactivate().view( 'index' ).activeModeOff()

  contact: ->
    return contact for contact in @contacts when contact.user is @Application.user
    null

  writes: ->
    @view( 'index' ).showWrites()

  sendPhotos: ( photos ) ->
    photosId = ( photo.id for photo in photos )
    @query 'dialogs.send_photos', dialog_id: @id, photos_id: photosId

  loadHistory: ->
    @Message.select history: dialog_id: @id, offset: @messages.length
