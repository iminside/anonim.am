Nali.View.extend UserEmail:
  
  insertTo: -> '.UserInterface'

  events: [
    'hide on click at    .wrapper'
    'notHide on click at .dialog'
  ]

  notHide: ( event ) ->
    event.stopPropagation()
