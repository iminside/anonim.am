Nali.View.extend MessageBuild:

  events: [
    'toggleEmoticons            on click    at .emoticons'
    'pasteEmoticon              on click    at .emoticons_list i'
    'formSubmit                 on submit   at form'
    'writesMessage, sendByEnter on keypress at textarea'
    'addNewLine                 on keydown  at textarea'
  ]

  helpers:

    emoticons: ->
      array = [
        61, 45, 69, 70, 71, 57, 58, 59, 62, 53, 20, 38, 43, 44, 73, 10, 48, 47, 46, 11, 40, 33, 72, 21, 22, 39,
        37, 54, 25, 27, 60, 31, 55, 17, 56, 19,  1, 63, 32, 24, 13, 26, 12, 28, 29,  7, 41,  8,  3, 66, 65, 23,
        35, 14, 30, 75, 67, 15, 51, 52, 74,  2, 34, 50, 76, 64,  9, 36,  5, 68, 42, 16, 18,  6, 49,  0,  4
      ]
      emoticons = ''
      for i in array
        hex        = i.toString 16
        code       = '00'.substr( 0, 3 - hex.length ) + hex
        emoticons += "<i class=\"emoticons-smile#{ i + 1 }\" data-code=\"e#{ code }\"></i> "
      emoticons

  onShow: ->
    @form      = @element.find 'form'
    @textarea  = @form.find '.message textarea'
    @emoticons = @element.find '.emoticons_list'
    @textarea.autosize()

  onHide: ->
    @emoticons.getNiceScroll()?.remove()
    delete @textarea
    delete @emoticons
    delete @form

  formSubmit: ( event ) ->
    @lastWriteTime = 0
    @hideEmoticons() if @emoticons.hasClass 'emoticons_show'
    @textarea.trigger 'autosize.resize'

  toggleEmoticons: ( event ) ->
    if @emoticons.hasClass 'emoticons_show' then @hideEmoticons() else @showEmoticons()

  showEmoticons: ->
    @emoticons.addClass 'emoticons_show'
    setTimeout ( => @emoticons.niceScroll() ), 200
    @

  hideEmoticons: ->
    @emoticons.removeClass 'emoticons_show'
    @emoticons.getNiceScroll().remove()
    @

  pasteEmoticon: ( event ) ->
    code = '&#x' + @_( event.target ).data( 'code' ) + ';'
    text = @_( '<textarea>' ).html( code ).text()
    @textarea.insertAtCaret( text ).trigger( 'change' ).trigger 'autosize.resize'

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
