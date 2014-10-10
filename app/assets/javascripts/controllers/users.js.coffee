Nali.Controller.extend Users:
  
  actions: 
    default: 'index'
        
    index: ( collection ) ->
      return @redirect 'home' unless @Application.user
      collection.add @Application.user
      
    person: ( collection ) ->
      return @redirect 'home' unless @Application.user
      collection.add @Application.user
      
    settings: ( collection ) ->
      return @redirect 'home' unless @Application.user
      collection.add @Application.user
      
    'auth/:token': ( collection, { token } ) ->
      @query 'users.auth', token: token, 
        ( id ) => 
          @Application.user = @Model.User.find id
          @Cookie.set 'token', token
          @redirect 'user'
        =>
          @Cookie.remove 'token'
          @redirect 'home'