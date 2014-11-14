Nali.View.extend MessagephotoPreview:

  events: 'open on click'

  onShow: ->
    @preview ?= @element.find '.preview'

  open: ( event ) ->
    event.stopPropagation()
    @Application.user.showSlides @my.message.photos, @my.photo

  resize: ( w, h ) ->
    @element[0].style.width = w
    @preview[0].style.paddingTop = h
    @preview.css backgroundImage: 'url(' + @my.photo.url( @element.width(), @element.height(), false ) + ')'
