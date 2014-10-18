Nali.Model.extend Dialog:
  
  hasMany: [ 'contacts', 'messages' ]
  
  beforeShow: 
    index: ->
      @messages.order by: 'created'
      @message = @Message.build dialog_id: @id, user_id: @Application.user.id
  
  contact: ->
    return contact for contact in @contacts when contact.user is @Application.user
      
  writes: ->
    @view( 'index' ).showWrites()