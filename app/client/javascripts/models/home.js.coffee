Nali.Model.extend Home:
  attributes:
    color:
      default: null
      presence: true
      inclusion: ['red', 'orange', 'yellow', 'green', 'azure', 'blue', 'violet']

    gender:
      default: null
      presence: true
      inclusion: ['man', 'woman']

  onUpdateGender: ->
    if @color? and @gender?
      @query 'users.create', gender: @gender, color: @color,
        ( token ) =>
          @redirect 'user/auth/' + token
        =>
          @redirect 'home'
