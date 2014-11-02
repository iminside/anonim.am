Nali.View.extend UserDeletePhotos:

  insertTo: -> '.UserInterface'

  events: [
    'hide on click at    .wrapper'
    'notHide on click at .dialog'
  ]

  notHide: ( event ) ->
    event.stopPropagation()
