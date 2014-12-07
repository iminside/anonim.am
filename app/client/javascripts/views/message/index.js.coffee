Nali.View.extend MessageIndex:

  helpers:

    owner: ->
      if @my.user is @Application.user then 'Я' else @getOf @my.user, 'name'

    text: ->
      text = '<p>'
      if @my.text?
        message = "#{ @my.text }".replace( /&/g, '&amp;' ).replace( /"/g, '&quot;' )
          .replace( /'/g, '&#039;' ).replace( /</g, '&lt;'   ).replace( />/g, '&gt;'   )
        for sym in message
          code = sym.charCodeAt(0)
          if code in [ 58881..58978 ] then text += '<i>' + sym + '</i> '
          else if code is 10          then text += '<br />'
          else                             text += sym
      text + '</p>'

  onShow: ->
    @resizingPhotos()
    @subscribeTo @my.messagephotos, 'update.length', @resizingPhotos
    @my.dialog.viewIndex().scrollTo @

  resizingPhotos: ->
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
