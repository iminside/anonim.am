Nali.View.extend UserSlider:

  insertTo: -> '.UserInterface'

  events: 'next on click at .slide'

  onShow: ->
    @slide ?= @element.find '.slide'
    @slideW = @slide.width()
    @slideH = @slide.height()
    @startSlider()

  onHide: ->
    @slide.html ''
    delete @current
    delete @slides

  setSlides: ( @slides, @current ) ->
    @

  startSlider: ->
    @showSlide()
    @preload @nextSlide()
    @preload @prevSlide()
    @

  showSlide: ->
    @slide.html( '' ).append(
      @_ '<img src="' + @current.large + '" style="max-width:' + @slideW + 'px;max-height:' + @slideH + 'px; alt="" />'
    )

  next: ( event ) ->
    event.stopPropagation()
    @current = @nextSlide()
    @showSlide()
    @preload @nextSlide()

  prev: ->
    @current = @prevSlide()
    @showSlide()
    @preload @prevSlide()

  nextSlide: ->
    if ( slide = @slides[ @slides.indexOf( @current ) + 1 ] )? then slide else @slides[0]

  prevSlide: ->
    if ( slide = @slides[ @slides.indexOf( @current ) - 1 ] )? then slide else @slides[ @slides.length - 1 ]

  preload: ( slide ) ->
    image     = new Image
    image.src = slide.large
    @
