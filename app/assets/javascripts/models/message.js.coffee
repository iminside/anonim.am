Nali.Model.extend Message:

  hasMany: [
    photos: through: 'messagephoto'
    'messagephotos'
  ]
      
  attributes:
    dialog_id:
      format:   'number'
    user_id:
      format:   'number'
    text:
      presence: true
      length:   in: [ 1..1000 ]

  createMessage: ( params ) ->
    params.dialog_id = @dialog_id
    params.user_id   = @user_id
    params.text      = params.text.trim().replace( /[\r|\n]+/g, '\n' ).replace /\ +/g, ' ' 
    @Message.create params
