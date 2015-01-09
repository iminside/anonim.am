Nali.View.extend PhotoPreview:

  events: 'onClick on click'

  onShow: ->
    @preview ?= @element.find '.preview'
    @preview.css backgroundImage: 'url(' + @my.url( @element.width(), @element.height(), false ) + ')'

  onClick: ( event ) ->
    event.stopPropagation()
    if @selectMode
      @element.toggleClass 'select_mode'
      @my.toggleSelected()
    else if @avatarMode
      @my.user.viewPhotos().avatarModeOff()
      @my.showAvatar()
    else
      @my.user.showSlides @my.user.photos, @my

  selectModeOn: ->
    if @visible
      @selectMode = true
      @element.addClass 'select_mode'

  selectModeOff: ->
    if @visible
      @selectMode = false
      @element.removeClass 'select_mode'

  avatarModeOn: ->
    if @visible
      @avatarMode = true
      @element.addClass 'avatar_mode'

  avatarModeOff: ->
    if @visible
      @avatarMode = false
      @element.removeClass 'avatar_mode'
