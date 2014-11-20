Nali.View.extend UserAccount:

  layout: -> @my.viewSettings()

  onShow:  ->
    @Application.setTitle 'Аккаунт'
    @layout().activeTab '.account'
