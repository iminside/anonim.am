Nali.Model.extend Photo:

  hasMany:   'messagephotos'

  belongsTo: 'user'

  attributes:
    user_id:
      format:  'number'
    secret:
      length:  is: 32

  uploadPhoto: ( image, progressCallback ) ->
    @query 'photos.upload_photo', image: image, progressCallback
    @

  uploadAvatar: ( image, success ) ->
    @query 'photos.upload_avatar', image: image, success
    @

  url: ( width, height, limit = true ) ->
    [ m, w, h ] = if limit then [ 'limit',        Math.floor( width ), Math.floor( height ) ]
    else                        [ 'fill,g_faces', Math.ceil( width ),  Math.ceil( height )  ]
    'http://res.cloudinary.com/isite-im/image/upload/c_' + m + ',w_' + w + ',h_' + h + '/' + @secret + '.jpg'

  _selectModeOn: ->
    @viewPreview().selectModeOn()

  _selectModeOff: ->
    @update selected: false
    @viewPreview().selectModeOff()

  _avatarModeOn: ->
    @viewPreview().avatarModeOn()

  _avatarModeOff: ->
    @viewPreview().avatarModeOff()

  toggleSelected: ->
    @update selected: if @selected then false else true
