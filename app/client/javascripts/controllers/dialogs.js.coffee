Nali.Controller.extend Dialogs:

  actions:
    default: 'index'

    'index/id': ->
      @redirect 'home' unless @Application.user
