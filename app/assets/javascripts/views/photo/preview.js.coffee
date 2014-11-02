Nali.View.extend PhotoPreview:

  events: 'openOrMode on click'

  openOrMode: ( event ) ->
    event.stopPropagation()
    if @selectMode
      @element.toggleClass 'unselected'
      @my.user.toggleSelectPhoto @my
    else if @avatarMode
      @my.user.view( 'photos' ).selectAvatarOff()
      @my.avatar()
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
