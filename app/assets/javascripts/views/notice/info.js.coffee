Nali.View.NoticeInfo.expand

  hideDelay: 200
  
  insertTo: -> '.UserInterface'
  
  onShow: -> 
    @element.addClass 'show'
    setTimeout ( => @hide() ), 3000
    
  onHide: ->
    @element.removeClass 'show'