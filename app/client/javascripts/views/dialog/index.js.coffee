Nali.View.extend DialogIndex:

  layout: ->
    @Application.user.view 'interface'

  onShow: ->
    @Application.setTitle 'Диалог'
    @messagesBox = @element.find '.MessagesIndexRelation'
    @messagesBox.niceScroll()

  onHide: ->
    @messagesBox.getNiceScroll().remove()

  scrollDown: ->
    @messagesBox[0].scrollTop = @messagesBox[0].scrollHeight
    clearTimeout @scrollTimer if @scrollTimer?
    @scrollTimer = setTimeout =>
      @messagesBox[0].scrollTop = @messagesBox[0].scrollHeight
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
