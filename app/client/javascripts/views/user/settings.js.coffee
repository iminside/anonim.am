Nali.View.extend UserSettings:

  layout: -> @my.viewInterface()

  onShow: ->
    @_( 'a.settings' ).addClass 'button_hover'
    @yield.niceScroll railoffset: left: 14

  onHide: ->
    @_( 'a.settings' ).removeClass 'button_hover'
    @yield.getNiceScroll().remove()

  activeTab: ( selector ) ->
    @tabs      ?= @element.find '.settingsBar > .tabs'
    @tabsCount ?= @tabs.children().length
    @marker    ?= @element.find( '.settingsBar > .marker' ).width 100 / @tabsCount + '%'
    index       = @tabs.find( '.active' ).removeClass( 'active' ).end().find( selector ).addClass( 'active' ).index()
    @marker.css marginLeft: index / @tabsCount * 100 + '%'
    @yield[0].scrollTop = 0
