Nali.View.extend HomeIndex:
  
  onShow: ->
    @Application.setTitle 'Сервис анонимного общения'
  
  selectColor: ( { @color } ) ->
    @element.find( '.gender_buttons' )
      .removeClass( 'red orange yellow green azure blue violet' )
      .addClass( @color )
      .end()
      .find( '.logo' )
      .addClass 'logo_animation'
  
  selectGender: ( { gender } ) ->
    @model.newUser gender, @color