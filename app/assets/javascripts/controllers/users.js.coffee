Nali.Controller.extend Users:
  
  actions: 
    default: 'index'
    
    before: 
      '! auth': ->
        @redirect 'home' unless @Application.user
          
    after:
      '! auth': ->
        @collection.add @Application.user
        
    index: ->
      
    person: ->
      
    settings: ->
      
    'auth/:token': ->
      @query 'users.auth', token: @params.token, 
        ( id ) => 
          @Application.user = @Model.User.find id
          @Cookie.set 'token', @params.token
          @redirect 'user'
        =>
          @Cookie.remove 'token'
          @redirect 'home'
      @stop()