Nali.Model.extend Contact:

  belongsTo: [
    'user'
    contact: model: 'user'
    'dialog'
  ]

  attributes:
    contact_id:
      format:  'number'
    user_id:
      format:  'number'
    dialog_id:
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
      @Notice.info "#{ @user.name } больше не хочет общаться с Вами, диалог удален"

  fresh: ( params ) ->
    @Notice.info 'Вам подобран новый собеседник'
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

  deleteAccept: ->
    @destroyInitiator         = true
    @contact.destroyInitiator = true
    @dialog.destroy()
    @hide 'delete'
