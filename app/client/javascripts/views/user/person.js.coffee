Nali.View.extend UserPerson:

  layout: -> @my.viewSettings()

  onShow: ->
    @Application.setTitle 'Образ'
    @layout().activeTab '.person'
