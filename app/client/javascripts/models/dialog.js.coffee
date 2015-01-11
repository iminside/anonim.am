Nali.Model.extend Dialog:

  hasMany: 'messages'

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
    return contact for contact in @Application.user.contacts when contact.dialog_id is @id
    null

  writes: ->
    @viewIndex().showWrites()

  loadHistory: ->
    @Message.select history: dialog_id: @id, offset: @messages.length
