Nali.View.extend UserPhotos:

  insertTo: -> '.UserInterface'

  events: [
    'hide on click at    .wrapper'
    'notHide on click at .photos'
  ]

  helpers:

    selectedCount: ->
      @redrawOn @my, 'update.selectedPhotos'
      if count = @my.selectedPhotos?.length
        'Отмечено ' + count + ' фото'
      else 'Нажмите на фото, чтобы отметить его'

  onShow: ->
    @_( 'a.photos' ).addClass 'button_hover'
    @photosBox ?= @element.find '.PhotosPreviewRelation'
    @photosBox.niceScroll cursorborder: '1px #333 solid'

  onHide: ->
    @_( 'a.photos' ).removeClass 'button_hover'
    @selectPhotosOff()
    @photosBox.getNiceScroll().remove()

  notHide: ( event ) ->
    event.stopPropagation()

  selectPhotosOn: ->
    if @my.photos.length
      @element.find( '.photos' ).addClass 'selectionMode'
      @my.selectPhotosOn()
    else @Notice.info 'Для начала загрузите фотографии'

  selectPhotosOff: ->
    @element.find( '.photos' ).removeClass 'selectionMode'
    @my.selectPhotosOff()

  selectAvatarOn: ->
    if @my.photos.length
      @element.find( '.photos' ).addClass 'avatarMode'
      @my.selectAvatarOn()
    else @Notice.info 'Для начала загрузите фотографии'

  selectAvatarOff: ->
    @element.find( '.photos' ).removeClass 'avatarMode'
    @my.selectAvatarOff()
