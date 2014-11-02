Nali.View.extend MessagephotoPreview:

  events: 'open on click'

  open: ( event ) ->
    event.stopPropagation()
    @Application.user.showSlides @my.message.photos, @my.photo
