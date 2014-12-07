Nali.Model.Notice.expand

  newmsg: ->
    @AudioNotice.play @Application.user.sound if @AudioNotice.supported
