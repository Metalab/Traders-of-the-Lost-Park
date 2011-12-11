
window.Traders =
  Models: {}
  Views: {}
  Controllers: {} # I know this nothing backbone still has be I prefer the name
  Cards: {}



$(document).ready ->
  window.game = new Traders.Controllers.Game()
  if document.body && document.body.offsetWidth
    winW = document.body.offsetWidth
    winH = document.body.offsetHeight

  if (document.compatMode=='CSS1Compat' && document.documentElement && document.documentElement.offsetWidth )
    winW = document.documentElement.offsetWidth
    winH = document.documentElement.offsetHeight

  if (window.innerWidth && window.innerHeight)
    winW = window.innerWidth
    winH = window.innerHeight
  $('[name=player_name]').focus()
  jaws.assets.add("/images/card-dollar.png")

  jaws.start(window.game, {fps: 5})

  true
