#= require jquery.min
#= require jquery.autosize.min
#= require jquery.nicescroll.min
#= require jquery.Jcrop.min
#= require jquery.functions
#= require nali
#= require audio_notice
#= require_tree .

Nali.Application.expand(

  onConnectionOpen: ->
    if token = @Cookie.get 'token' then @auth token
    else @redirect()

  auth: ( token, url ) ->
    @query 'users.auth', token: token,
      ( id ) =>
        @user = @Model.User.find id
        @Cookie.set 'token', token, live: 5000
        @redirect url
      =>
        @redirect 'home'

).run
  domEngine: jQuery
  title:     'Сервис анонимного общения'
