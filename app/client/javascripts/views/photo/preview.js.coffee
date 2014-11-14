Nali.View.extend PhotoPreview:

  events: 'openOrMode on click'

  onShow: ->
    @preview ?= @element.find '.preview'
    @preview.css backgroundImage: 'url(' + @my.url( @element.width(), @element.height(), false ) + ')'

  openOrMode: ( event ) ->
    event.stopPropagation()
    if @selectMode
      @element.toggleClass 'unselected'
      @my.toggleSelected()
    else if @avatarMode
      @my.user.viewPhotos().avatarModeOff()
      @my.showAvatar()
    else
      @my.user.showSlides @my.user.photos, @my

  selectModeOn: ->
    if @visible
      @selectMode = true
      @element.addClass 'unselected'

  selectModeOff: ->
    if @visible
      @selectMode = false
      @element.removeClass 'unselected'

  avatarModeOn: ->
    if @visible
      @avatarMode = true
      @element.addClass 'forAvatar'

  avatarModeOff: ->
    if @visible
      @avatarMode = false
      @element.removeClass 'forAvatar'
