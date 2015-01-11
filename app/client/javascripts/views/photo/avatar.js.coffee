Nali.View.extend PhotoAvatar:

  insertTo: -> '.UserInterface'

  onShow:  ->
    photoBox  = @element.find '.photo'
    w = photoBox.width()
    h = photoBox.height()
    @photo = @_( '<img src="' + @my.url( w, h ) + '" crossorigin="anonymous" />' ).appendTo( photoBox ).Jcrop
      aspectRatio: 1
      minSize:     [ 64, 64 ]
      onSelect:    ( coord ) => @onSelect coord

  onHide: ->
    @photo.data( 'Jcrop' ).destroy()
    @photo.remove()
    delete @coord

  onSelect: ( @coord ) ->

  crop: ->
    return @Notice.info 'Выделите область изображения для создания аватара' unless @coord
    canvas            = document.createElement 'canvas'
    canvas.width      = 64
    canvas.height     = 64
    context           = canvas.getContext '2d'
    context.drawImage @photo[0], @coord.x, @coord.y, @coord.w, @coord.h, 0, 0, 64, 64
    @query 'photos.upload_avatar', image: canvas.toDataURL( 'image/jpeg' ), =>
      @hide()
      @Notice.info 'Аватар сохранен'
