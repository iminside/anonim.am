Nali.Model.extend Contact:
  
  attributes:
    contact_id:   
      default: 0
      format:  'number'
    user_id:  
      default: 0
      format:  'number'
    dialog_id: 
      default: 0
      format:  'number'
    active:
      default:  true
      format:  'boolean'
    counter:
      default: 0
      format:  'number'
  
  activeHistory: []
  
  onDestroy: ->
    if @user is @Application.user 
      @redirect 'user' if @active
    else unless @destroyInitiator
      @Notice.info message: "#{ @user.name } больше не хочет общаться с Вами, диалог удален"
  
  fresh: ( params ) ->
    @Notice.info message: 'Вам подобран новый собеседник'
    @toDialog()
    
  toDialog: ->
    @redirect 'dialog/' + @dialog_id
    @
    
  activate: ->
    @update( active: true, counter: 0 ).save()
    @user.hideDialogs()
    @
    
  deactivate: ->
    @update( active: false ).save()
    @
  
  removeDialog: ->
    @show 'remove'
    
  removeDialogAccept: ->
    @destroyInitiator         = true
    @contact.destroyInitiator = true
    @dialog.destroy()
    @hide 'remove'