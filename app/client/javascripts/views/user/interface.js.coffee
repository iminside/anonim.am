Nali.View.extend UserInterface:

  helpers:
    search: ->
      if @my.search then 'button_hover' else ''
    userFace: ->
      if @my.avatar?
        '<span class="avatar" style="background-image: url(' + @my.avatarPath + ')"></span>'
      else
        '<i class="faceicon-' + @my.gender + @my.image + '"></i>'

  onShow: ->
    @element.find( '.ContactsIndexRelation' ).niceScroll railalign: 'left'
    @subscribeTo @my, 'update.color', @changeFavicon
    @changeFavicon()

  onHide: ->
    @element.find( '.ContactsIndexRelation' ).getNiceScroll().remove()

  changeFavicon: ->
    @_( '#favicon' ).replaceWith(
      '<link id="favicon" rel="shortcut icon" href="/images/favicons/favicon_' + @my.color + '.ico" type="image/x-icon">'
    )
