Nali.View.extend DialogIndex:
    
  layout: -> 
    @Application.user.view 'interface'
  
  onShow: ->
    @Application.setTitle 'Диалог'
    @my.contact().activate()
    @messagesBox = @element.find '.MessagesIndexRelation'
    @messagesBox.niceScroll
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