Nali.Model.extend User:

  hasMany: [ 'contacts', 'photos' ]

  attributes:
    name:
      length:    in: [ 3..30 ]
      warning:  'Длина имени должна быть от 3 до 30 символов'
    color:
      presence:  true
      inclusion: [ 'red', 'orange', 'yellow', 'green', 'azure', 'blue', 'violet' ]
    gender:
      presence:  true
      inclusion: [ 'man', 'woman' ]
    image:
      default:   0
      format:    'number'
    search:
      default:   0
      inclusion: [ 0..3 ]
    online:
      default:   false
      format:    'boolean'
    who:
      default:   'all'
      inclusion: [ 'man', 'woman', 'all' ]
    how:
      default:   1
      inclusion: [ 1..3 ]
    sound:
      default:   0
      inclusion: [ 0..25 ]
    avatar:      null

  cloning: ->
    @getter 'avatarPath',  => '/images/avatars/'  + @avatar + '.jpg'

  beforeShow:
    photos: ->
      @photo = @Photo.new user_id: @id
      @photos.order by: 'created', desc: true
    interface: ->
      @contacts.order by: ( one, two ) ->
        switch
          when one.counter > two.counter                     then -1
          when one.counter < two.counter                     then  1
          when one.contact.online and not two.contact.online then -1
          when not one.contact.online and two.contact.online then  1
          when one.contact.name  < two.contact.name          then -1
          when one.contact.name  > two.contact.name          then  1
          when one.contact.color < two.contact.color         then -1
          when one.contact.color > two.contact.color         then  1
          else 0

  onUpdateHow: ->
    @deactivateSearch()

  onUpdateWho: ->
    @deactivateSearch()

  changeColor: ( { color } ) ->
    @update( color: color ).save()

  changeImage: ( { image } ) ->
    @update( image: image ).save()

  changeColorDialog: ->
    if ( view = @view( 'color' ) ).visible then view.hide() else view.show()

  photosDialog: ->
    @show 'photos'

  toggleSearch: ->
    if @search then @deactivateSearch() else @activateSearch()

  activateSearch: ->
    @update( search: @how ).save() unless @search
    @query 'users.search'

  deactivateSearch: ->
    @update( search: 0 ).save() if @search

  toggleDialogs: ->
    if @_( '.contacts' ).hasClass 'show_contacts' then @hideDialogs() else @showDialogs()

  showDialogs: ->
    @_( '.toolbar a.dialogs' ).addClass 'button_hover'
    @_( '.contacts' ).addClass 'show_contacts'
    @_( document ).on 'click.dialogs', ( event ) =>
      @hideDialogs() unless @_( event.target ).closest( 'a.dialogs, div.contacts' ).length

  hideDialogs: ->
    @_( '.toolbar a.dialogs' ).removeClass 'button_hover'
    @_( '.contacts' ).removeClass 'show_contacts'
    @_( document ).off 'click.dialogs'

  emailSend: ( { email } ) ->
    if /^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,4})+$/.test email
      @query 'users.to_email', email: email, =>
        @hide 'email'
        @Notice.info 'Кнопка автологина отправлена на ' + email
    else @Notice.info 'Введите правильный e-mail'

  deleteAccept: ->
    @destroy => @logoutAccept()

  logoutAccept: ->
    @query 'users.logout'
    @Cookie.remove 'token'
    @Application.user = null
    @redirect 'home'

  showSlides: ( slides, start ) ->
    @view( 'slider' ).setSlides( slides, start ).show()

  toggleSelectPhoto: ( photo ) ->
    if photo in @selectedPhotos
      @selectedPhotos.splice @selectedPhotos.indexOf( photo ), 1
    else @selectedPhotos.push photo
    @trigger 'update.selectedPhotos'

  resetSelectedPhotos: ->
    @selectedPhotos = []
    @trigger 'update.selectedPhotos'
    @

  sendSelectedPhotos: ->
    unless dialog = @Application.activeDialog
      return @Notice.info 'Откройте диалог с пользователем, которому хотите отправить фотографии'
    unless @selectedPhotos?.length
      return @Notice.info 'Выберите фотографии для отправки'
    if @selectedPhotos.length > 10
      return @Notice.info 'Можно отправлять не более 10-ти фотографий сразу'
    dialog.sendPhotos @selectedPhotos
    @hide 'photos'

  deleteSelectedPhotos: ->
    if @selectedPhotos?.length
      @show 'deletePhotos'
    else @Notice.info 'Выберите фото для удаления'

  deletePhotosAccept: ->
    if @selectedPhotos?.length
      photo.destroy() for photo in @selectedPhotos
    @resetSelectedPhotos()
    @hide 'deletePhotos'

  changeAvatar: ->
    @show( 'photos' ).avatarModeOn().cancelIsClose = true

  deleteAvatar: ->
    @query 'users.delete_avatar'
