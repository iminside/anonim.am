Nali.Model.extend Photo:

  hasMany: 'messagephotos'

  attributes:
    user_id:
      format:  'number'
    secret:
      length:  is: 32

  cloning: ->
    @getter 'small',  => '/images/photos/small/'  + @secret + '.jpg'
    @getter 'medium', => '/images/photos/medium/' + @secret + '.jpg'
    @getter 'large',  => '/images/photos/large/'  + @secret + '.jpg'

  uploadPhoto: ( image, progressCallback ) ->
    @query 'photos.upload_photo', image: image, progressCallback
    @

  uploadAvatar: ( image, success ) ->
    @query 'photos.upload_avatar', image: image, success
    @

  _selectModeOn: ->
    @view( 'preview' ).selectModeOn()

  _selectModeOff: ->
    @view( 'preview' ).selectModeOff()

  _avatarModeOn: ->
    @view( 'preview' ).avatarModeOn()

  _avatarModeOff: ->
    @view( 'preview' ).avatarModeOff()

