Nali.View.extend HomeIndex:
  
  onShow: ->
    @Application.setTitle 'Сервис анонимного общения'
    colors = @element.find( '.colors' ).addClass( 'show' )
    setTimeout => 
      colors.addClass( 'shown' ).removeClass 'show'
      ( text = @element.find( '.logo div:nth-child(2)' ) ).animate opacity: 0, 300, =>
        text.text 'Какой цвет Вам нравится?'
        text.animate opacity: 1, 300
    , 1000
  
  selectColor: ( { @color } ) ->
    @element.find( '.gender_buttons' )
      .removeClass( 'red orange yellow green azure blue violet' )
      .addClass( @color )
      .end()
      .find( '.logo' )
      .addClass 'logo_animation'
  
  selectGender: ( { gender } ) ->
    @model.newUser gender, @color