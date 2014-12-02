Nali.View.extend HomeIndex:

  onShow: ->
    colors = @element.find( '.colors' ).addClass( 'show' )
    setTimeout =>
      colors.addClass( 'shown' ).removeClass 'show'
      ( text = @element.find( '.logo div:nth-child(2)' ) ).animate opacity: 0, 300, =>
        text.text 'Какой цвет Вам нравится?'
        text.animate opacity: 1, 300
    , 1000
