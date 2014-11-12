Nali.Model.extend Photo:

  hasMany:   'messagephotos'

  belongsTo: 'user'

  attributes:
    user_id:
      format:  'number'
    secret:
      length:  is: 32

  cloning: ->
    @getter 'small',  => @url 150
    @getter 'medium', => @url 300
    @getter 'large',  => @url 800

  uploadPhoto: ( image, progressCallback ) ->
    @query 'photos.upload_photo', image: image, progressCallback
    @

  uploadAvatar: ( image, success ) ->
    @query 'photos.upload_avatar', image: image, success
    @

  url: ( width ) ->
    'http://res.cloudinary.com/isite-im/image/upload/c_limit,w_' + width + '/' + @secret + '.jpg'

  _selectModeOn: ->
    @view( 'preview' ).selectModeOn()

  _selectModeOff: ->
    @view( 'preview' ).selectModeOff()

  _avatarModeOn: ->
    @view( 'preview' ).avatarModeOn()

  _avatarModeOff: ->
    @view( 'preview' ).avatarModeOff()

