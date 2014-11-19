Nali.View.extend UserFace:

  helpers:
    face: ->
      if @my.avatar?
        '<span class="avatar" style="background-image: url(' + @my.avatarPath + ')"></span>'
      else
        '<i class="faceicon-' + @my.gender + @my.image + '"></i>'
