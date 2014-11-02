Nali.Controller.extend Users:
  
  actions: 
    default: 'index'
    
    before: 
      '! auth': ->
        @redirect 'home' unless @Application.user?
          
    after:
      '! auth': ->
        @collection.add @Application.user
        
    index:   ->
      
    person:  ->
      
    sounds:  ->

    search:  ->

    account: ->
      
    'auth/:token': ->
      if @params.token?
        @Application.auth @params.token, 'user'
        @stop()
      else @redirect 'home'
