Nali.View.extend MessageIndex:
  
  helpers:
      
    owner: ->
      if @my.user is @Application.user then 'Я' else @getOf @my.user, 'name' 
      
    text: ->
      text    = '<span class="text">'
      message = "#{ @my.text }".replace( /&/g, '&amp;' ).replace( /"/g, '&quot;' )
        .replace( /'/g, '&#039;' ).replace( /</g, '&lt;'   ).replace( />/g, '&gt;'   )
      for sym in message
        code = sym.charCodeAt(0)
        if code in [ 57344..57420 ] then text += '<i>' + sym + '</i> '
        else if code is 10          then text += '<br />'
        else                             text += sym
      text + '</span>'
      
  onShow: ->
    @my.dialog.view( 'index' ).hideWrites().scrollDown()