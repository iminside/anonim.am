Nali.Model.extend Message:

  hasMany: [
    'messagephotos'
    photos: through: 'messagephotos'
  ]

  belongsTo: [ 'user', 'dialog' ]

  attributes:
    dialog_id:
      format:   'number'
    user_id:
      format:   'number'
    text:
      presence: true
      length:   in: [ 1..1000 ]

  createMessage: ( { photosId } ) ->
    @text = @text.toString().trim().replace( /[\r|\n]+/g, '\n' ).replace /\ +/g, ' ' if @text
    @query 'messages.create', dialog_id: @dialog_id, text: @text, photos_id: ( photosId or [] )
    @update text: null, false
