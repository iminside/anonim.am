Nali.Model.extend Home:
  
  forced: true
         
  newUser: ( gender, color ) ->  
    @query 'users.build', gender: gender, color: color, 
      ( token ) =>
        @redirect 'user/auth/' + token
      =>
        @redirect 'home'