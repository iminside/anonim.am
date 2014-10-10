Nali.Model.extend Message:
      
  attributes:
    dialog_id:
      default:  0
      format:   'number'
    user_id:
      default:  0
      format:   'number'
    text:
      presence: true
      length:   in: [ 1..300 ]
    
    
  createMessage: ( params ) ->
    params.dialog_id = @dialog_id
    params.user_id   = @user_id
    params.text      = params.text.trim().replace( /[\r|\n]+/g, '\n' ).replace /\ +/g, ' ' 
    @Message.create params
