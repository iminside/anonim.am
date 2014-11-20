Nali.View.extend UserFace:

  helpers:
    face: ->
      if @getMy( 'avatar' )?
        '<span class="avatar" style="background-image: url(' + @my.avatarPath + ')"></span>'
      else
        '<i class="faceicon-' + @getMy( 'gender' ) + @getMy( 'image' ) + '"></i>'
