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

  createMessage: ->
    @Message.create @copy @attributes
    @update text: null, false

  beforeSave: ->
    @text = @text.toString().trim().replace( /[\r|\n]+/g, '\n' ).replace /\ +/g, ' ' if @text
