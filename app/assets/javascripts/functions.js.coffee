jQuery.fn.focusToEnd = ->
  @each ->
    value = $( @ ).val()
    $( @ ).focus().val('').val value

  
jQuery.fn.insertAtCaret = ( myValue ) ->
  @each (i) ->
    if document.selection
      @focus()
      document.selection.createRange().text = myValue
      @focus()
    else if @selectionStart or @selectionStart is '0'
      [ startPos, endPos, scrollTop ] = [ @selectionStart, @selectionEnd, @scrollTop ]
      @value = @value.substring(0, startPos) + myValue + @value.substring(endPos, @value.length)
      @focus()
      @selectionStart = startPos + myValue.length
      @selectionEnd = startPos + myValue.length
      @scrollTop = scrollTop
    else
      @selectionStart += 1
      @selectionEnd   += 1
      @value += myValue
      @focus()
    return

