Nali.View.extend PhotoBuild:

  events: [
    'onDrop      on drop      at .dropBox'
    'onDragEnter on dragenter at .dropBox'
    'onDragOver  on dragover  at .dropBox'
    'onDragLeave on dragleave at .dropBox'
    'selectFile  on click     at .dropBox'
    'onSelect    on change    at input[type=file]'
  ]

  onShow: ->
    @progressIndicator  = @element.find '.progressBar .progress'
    @dropBox            = @element.find '.dropBox'
    @selectField        = @element.find 'input[type=file]'

  onDragEnter: ( event ) ->
    event.stopPropagation()
    @dropBox.addClass 'dragenter'

  onDragLeave: ( event ) ->
    event.stopPropagation()
    @dropBox.removeClass 'dragenter'

  onDragOver: ( event ) ->
    event.preventDefault()
    event.stopPropagation()

  selectFile: ( event ) ->
    event.stopPropagation()
    @selectField.click()

  onDrop: ( event ) ->
    event.preventDefault()
    event.stopPropagation()
    @dropBox.removeClass 'dragenter'
    @prepareImages Array::slice.call event.originalEvent.dataTransfer.files

  onSelect: ( event ) ->
    event.stopPropagation()
    @prepareImages Array::slice.call event.target.files

  checkImages: ( files ) ->
    for file in files
      ext = file.name.split( '.' ).reverse()[0].lower()
      unless ext in [ 'jpg', 'png', 'gif' ] and file.type in [ 'image/jpeg', 'image/png', 'image/gif' ]
        @Notice.info 'Загружать разрешено только изображения'
        return false
    files

  prepareImages: ( files ) ->
    if files.length > 10 then @Notice.info 'Пожалуйста, не загружайте более 10-ти фотографий одновременно'
    else if images = @checkImages files
      @prepareStart images
    @

  prepareStart: ( images ) ->
    @element.addClass 'preparing'
    @prepared     = []
    @prepareCount = images.length
    for image in images
      reader = new FileReader()
      reader.onload = ( event ) => @resizeImage event.target.result
      reader.readAsDataURL image
    @

  prepareProgress: ( dataUrl ) ->
    @prepared.push dataUrl
    width = ( @prepared.length ) / @prepareCount * 100 + '%'
    @progressIndicator[0].style.width = width
    @prepareEnd() if @prepared.length is @prepareCount
    @

  prepareEnd: ->
    @progressIndicator[0].style.width = '0%'
    @element.removeClass 'preparing'
    @uploadStart()
    @

  uploadStart: ->
    @uploadedCount = 0
    @element.addClass 'uploading'
    @query( 'photos.upload_photo', image: image, => @uploadProgress() ) for image in @prepared
    @

  uploadProgress: ->
    @uploadedCount += 1
    width = ( @uploadedCount ) / @prepared.length * 100 + '%'
    @progressIndicator[0].style.width = width
    @uploadEnd() if @prepared.length is @uploadedCount

  uploadEnd: ->
    @prepared = []
    @uploadedCount = 0
    @progressIndicator[0].style.width = '0%'
    @element.removeClass 'uploading'

  getNewSize: ( width, height ) ->
    max = 800
    switch
      when height >= width and height > max then [ Math.round( max * width / height ), max ]
      when height <= width and width > max  then [ max, Math.round( max * height / width ) ]
      else                                       [ width, height ]

  resizeImage: ( dataUrl ) ->
    image = new Image()
    image.onload = ( event ) =>
      img = event.target
      [ width, height ] = @getNewSize img.width, img.height
      canvas            = document.createElement 'canvas'
      canvas.width      = width
      canvas.height     = height
      context           = canvas.getContext '2d'
      context.drawImage img, 0, 0, width, height
      @prepareProgress canvas.toDataURL 'image/jpeg'
    image.src = dataUrl
