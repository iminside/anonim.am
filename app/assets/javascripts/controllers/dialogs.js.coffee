Nali.Controller.extend Dialogs:
  
  actions: 
    default: 'index'
    
    'index/id': ( collection ) ->
      @redirect 'home' unless @Application.user
  
  