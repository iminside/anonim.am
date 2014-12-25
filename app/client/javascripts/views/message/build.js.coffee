Nali.View.extend MessageBuild:

  events: [
    'toggleEmoticons            on click    at .emoticons'
    'pasteEmoticon              on click    at .emoticons_list i'
    'formSubmit                 on submit   at form'
    'writesMessage, sendByEnter on keypress at textarea'
    'addNewLine                 on keydown  at textarea'
  ]

  onShow: ->
    @form      ?= @element.find 'form'
    @textarea  ?= @form.find '.message textarea'
    @emoticons ?= @element.find '.emoticons_list'
    @textarea.autosize()

  onHide: ->
    @hideEmoticons()

  formSubmit: ( event ) ->
    @lastWriteTime = 0
    @hideEmoticons()
    @textarea.trigger 'autosize.resize'

  toggleEmoticons: ( event ) ->
    @hideEmoticons() or @showEmoticons()

  showEmoticons: ->
    unless @emoticons.hasClass 'emoticons_show'
      @emoticons.addClass 'emoticons_show'
      setTimeout ( => @emoticons.niceScroll() ), 200
      true
    else false

  hideEmoticons: ->
    if @emoticons.hasClass 'emoticons_show'
      @emoticons.removeClass 'emoticons_show'
      @emoticons.getNiceScroll().remove()
      true
    else false

  pasteEmoticon: ( event ) ->
    emoticon = String.fromCharCode 58880 + parseInt event.target.className.replace 'emoticon-', ''
    @textarea.insertAtCaret( emoticon ).trigger( 'change' ).trigger 'autosize.resize'

  sendByEnter: ( event ) ->
    if event.which is 13
      @textarea.trigger 'change'
      @form.trigger 'submit'
      event.preventDefault()

  addNewLine: ( event ) ->
    if event.which is 13 and ( event.ctrlKey or event.metaKey )
      @textarea.insertAtCaret String.fromCharCode 10

  writesMessage: ( event ) ->
    if event.which isnt 13 and ( newLastTime = new Date().getTime() ) - ( @lastWriteTime ?= 0 ) > 3000
      @lastWriteTime = newLastTime
      @query 'dialogs.writes'
