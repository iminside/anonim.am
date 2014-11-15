Nali.Model.extend Home:

  forced: true
  color:  null

  onUpdateGender: ->
    if @color? and @gender?
      @query 'users.build', gender: @gender, color: @color,
        ( token ) =>
          @redirect 'user/auth/' + token
        =>
          @redirect 'home'
