Nali.View.extend DialogIndex:
    
  layout: -> 
    @Application.user.view 'interface'
  
  onShow: ->
    @Application.setTitle 'Диалог'
    @my.contact().activate()
    @messagesBox = @element.find '.MessagesIndexRelation'
    @messagesBox.niceScroll
      horizrailenabled: false
      cursoropacitymax: 0.5
      cursorwidth: 5
      zindex: 999
  
  onHide: ->
    @my.contact()?.deactivate()
    @messagesBox.getNiceScroll().remove()
    delete @messagesBox
    
  scrollDown: ->
    clearTimeout @scrollTimer if @scrollTimer?
    @scrollTimer = setTimeout =>
      @messagesBox.getNiceScroll().resize().doScrollPos( 0, @messagesBox[0].scrollHeight )
      delete @scrollTimer 
    , 5
    
  showWrites: ->
    clearTimeout @writesTimer if @writesTimer?
    @writesBox ?= @_( '.writes' )
    @writesBox.addClass 'show_writes' 
    @writesTimer = setTimeout =>
      @hideWrites()
    , 3500
    @
    
  hideWrites: ->
    clearTimeout @writesTimer if @writesTimer?
    @writesBox?.removeClass 'show_writes' 
    @writesTimer = null
    @