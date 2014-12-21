Nali.Model.extend User:

  hasMany: [ 'contacts', 'photos' ]

  attributes:
    name:
      length:    in: [ 3..30 ]
      notice:    warning:  'Длина имени должна быть от 3 до 30 символов'
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
      format:    'number'
    sound:
      default:   0
      inclusion: [ 0..25 ]
      format:    'number'
    avatar:      null

  cloning: ->
    @getter 'avatarPath',  -> 'http://res.cloudinary.com/isite-im/image/upload/' + @avatar + '.jpg'

  beforeShow:
    photos: ->
      @photo = @Photo.new user_id: @id
      @photos.order by: 'created', desc: true
      @selectedPhotos ?= @photos.where selected: true
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

  toggleSearch: ->
    if @search then @deactivateSearch() else @activateSearch()

  activateSearch: ->
    @upgrade search: @how unless @search
    @query 'users.search'

  deactivateSearch: ->
    @upgrade search: 0 if @search

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
        @hideEmail()
        @Notice.info 'Кнопка автологина отправлена на ' + email
    else @Notice.warning 'Введите правильный e-mail'

  logout: ->
    @Cookie.remove 'token'
    @Application.user = null
    @redirect 'home'

  showSlides: ( slides, start ) ->
    @viewSlider().setSlides( slides, start ).show()

  sendSelectedPhotos: ->
    unless dialog = @Application.activeDialog
      return @Notice.info 'Откройте диалог с пользователем, которому хотите отправить фотографии'
    unless @selectedPhotos?.length
      return @Notice.info 'Выберите фотографии для отправки'
    if @selectedPhotos.length > 10
      return @Notice.info 'Можно отправлять не более 10-ти фотографий сразу'
    dialog.message.createMessage photosId: @selectedPhotos.pluck 'id'
    @hidePhotos()

  deleteSelectedPhotos: ->
    if @selectedPhotos?.length then @showDeletePhotos()
    else @Notice.info 'Выберите фото для удаления'

  deletePhotos: ->
    if @selectedPhotos?.length
      photo.destroy() for photo in @selectedPhotos
    @viewPhotos().selectModeOff()
    @hideDeletePhotos()

  changeAvatar: ->
    @showPhotos().avatarModeOn().cancelIsClose = true

  deleteAvatar: ->
    @query 'users.delete_avatar'
