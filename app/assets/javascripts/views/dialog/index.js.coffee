Nali.View.extend DialogIndex:
    
  layout: -> 
    @Application.user.view 'interface'
  
  onShow: ->
    @Application.setTitle 'Диалог'
    @my.contact().activate()
    @messagesBox = @element.find '.MessagesIndexRelation'
    @messagesBox.scrollator()
  
  onHide: ->
    @my.contact()?.deactivate()
    
  scrollDown: ->
    clearTimeout @scrollTimer if @scrollTimer?
    @scrollTimer = setTimeout =>
      @messagesBox.animate scrollTop: @messagesBox[0].scrollHeight, 300
      delete @scrollTimer 
    , 5
    
  showWrites: ->
    clearTimeout @writesTimer if @writesTimer?
    @writesBox ?= @element.find '.writes' 
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