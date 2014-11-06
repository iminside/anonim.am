Nali.Model.extend Messagephoto:

  belongsTo: [ 'message', 'photo' ]

  attributes:
    message_id:
      format:   'number'
    photo_id:
      format:   'number'
