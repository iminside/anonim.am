Nali.View.extend UserFace:

  helpers:
    face: ->
      if @getMy( 'avatar' )?
        '<span class="avatar" style="background-image: url(http://res.cloudinary.com/anonim-am/image/upload/' + @my.avatar + '.jpg)"></span>'
      else
        '<i class="faceicon-' + @getMy( 'gender' ) + @getMy( 'image' ) + '"></i>'
