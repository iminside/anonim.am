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
      
  beforeShow: 
    interface: ->
      @contacts.order by: ( one, two ) ->
        switch 
          when one.counter > two.counter                               then -1
          when one.counter < two.counter                               then  1
          when one.contact.user.online and not two.contact.user.online then -1
          when not one.contact.user.online and two.contact.user.online then  1
          when one.contact.user.name  < two.contact.user.name          then -1
          when one.contact.user.name  > two.contact.user.name          then  1
          when one.contact.user.color < two.contact.user.color         then -1
          when one.contact.user.color > two.contact.user.color         then  1
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
        @Notice.info  message: 'Кнопка автологина отправлена на ' + email
    else @Notice.info message: 'Введите правильный e-mail'
    
  deleteAccept: ->
    @destroy => @logoutAccept()
    
  logoutAccept: ->
    @query 'users.logout'
    @Cookie.remove 'token'
    @Application.user = null
    @redirect 'home'