Nali.Model.extend User:
  
  hasMany: 'contacts'
  
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
      inclusion: [ 0, 1, 2, 3 ]
    online: 
      default:   false
      format:    'boolean'
    who:
      default:   'all'
      inclusion: [ 'man', 'woman', 'all' ]
    how:
      default:   1
      inclusion: [ 1, 2, 3 ]
    
  changeColor: ( { color } ) ->
    @update( color: color ).save()
    
  changeImage: ( { image } ) ->
    @update( image: image ).save()
    
  changeColorDialog: ->
    if ( view = @view( 'color' ) ).visible then view.hide() else view.show()
   
  toggleSearch: ->
    if @search then @update( search: 0 ).save() else @activateSearch()
  
  activateSearch: ->
    @update( search: @how ).save() unless @search
    @query 'users.search'
    
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
   
  to_bookmarks: ->
    @show 'bookmark'
    
  to_email: ->
    @show 'email'
    
  to_email_send: ( { email } ) ->
    if /^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,4})+$/.test email
      @query 'users.to_email', email: email
    else @Notice.info message: 'Введите правильный e-mail'
      
  removeDialog: ->
    @show 'remove'
    
  removeDialogAccept: ->
    @destroy => 
      @Cookie.remove 'token'
      @Application.user = null
      @redirect 'home'