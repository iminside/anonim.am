Nali.View.extend MessageIndex:

  helpers:

    owner: ->
      if @my.user is @Application.user then 'Я' else @getOf @my.user, 'name'

    text: ->
      @_text ?= @_prepareText()

  onShow: ->
    @_resizingPhotos()
    @subscribeTo @my.messagephotos, 'update.length', @_resizingPhotos
    @my.dialog.viewIndex().scrollTo @

  _prepareText: ->
    text = @my.text or ''
    for entity, regexp of { '&amp;': /&/g, '&quot;': /"/g, '&#039;': /'/g, '&lt;': /</g, '&gt;': />/g }
      text = text.replace regexp, entity
    text = text.replace /((https?|ftp|file):\/\/[-A-Z0-9+&@#\/%?=~_|!:,.;]*[-A-Z0-9+&@#\/%=~_|])/ig, '<a href="$1" target="_blank">$1</a>'
    html = '<p>'
    for sym in text
      code = sym.charCodeAt(0)
      if code in [ 58881..58978 ] then html += '<i>' + sym + '</i> '
      else if code is 10          then html += '<br />'
      else                             html += sym
    html + '</p>'

  _resizingPhotos: ->
    if count = @my.messagephotos.length
      matrix     = []
      lines      = Math.round Math.sqrt count
      start      = Math.round count / lines
      first      = ( lines - 1 ) * start
      last       = count - first
      startWidth = 100 / start + '%'
      lastWidth  = 100 / last  + '%'
      height     = 60 / ( ( lines - 1 ) / start  + 1 / last ) + '%'

      matrix.push startWidth for i in [ 0...first ]
      matrix.push lastWidth  for i in [ 0...last ]

      messagephoto.viewPreview().resize matrix[ index ], height for messagephoto, index in @my.messagephotos
