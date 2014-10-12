Nali.Controller.extend Homes:
  
  actions: 
    default: 'index'
    
    index: ->
      if @Application.user? then @redirect 'user'
      else if token = @Cookie.get 'token' then @redirect 'user/auth/' + token