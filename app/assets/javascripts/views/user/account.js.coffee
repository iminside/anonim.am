Nali.View.extend UserAccount:

  layout: -> @my.view 'settings'

  events:  []

  helpers: {}

  onShow:  ->
    @Application.setTitle 'Аккаунт'
    @element.closest( '.yield' )[0].scrollTop = 0
    @_( '#settingsBar' ).addClass 'active_4'

  onHide:  ->
    @_( '#settingsBar' ).removeClass 'active_4'
