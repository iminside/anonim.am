Nali.View.extend DialogIndex:

  layout: ->
    @Application.user.view 'interface'

  onShow: ->
    @Application.setTitle 'Диалог'
    @messagesBox = @element.find '.messages'
    @messagesBox.niceScroll mousescrollstep: 80
    @messagesBox.on 'scroll', ( event ) => @my.loadHistory() if event.currentTarget.scrollTop is 0

  onHide: ->
    @messagesBox.getNiceScroll().remove()
    @messagesBox.off()

  scrollTo: ( message ) ->
    @hideWrites()
    @messagesBox[0].scrollTop += message.viewIndex().element.height()

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
