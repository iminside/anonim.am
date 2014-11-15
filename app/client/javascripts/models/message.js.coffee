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

  createMessage: ( { text } ) ->
    params      = @copy @attributes
    params.text = text.trim().replace( /[\r|\n]+/g, '\n' ).replace /\ +/g, ' '
    @Message.create params
