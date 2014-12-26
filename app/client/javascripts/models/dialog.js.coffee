Nali.Model.extend Dialog:

  hasMany: [ 'contacts', 'messages' ]

  beforeShow:
    index: ->
      @loadHistory() unless @messages.length
      @messages.order by: 'created'
      @message ?= @Message.new dialog_id: @id, user_id: @Application.user.id
      @Application.activeDialog = @
      @contact().activate()

  afterHide:
    index: ->
      @Application.activeDialog = null
      @contact()?.deactivate()

  contact: ->
    return contact for contact in @contacts when contact.user is @Application.user
    null

  writes: ->
    @viewIndex().showWrites()

  loadHistory: ->
    @Message.select history: dialog_id: @id, offset: @messages.length
