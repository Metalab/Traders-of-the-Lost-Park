
window.Traders =
  Models: {}
  Views: {}
  Controllers: {} # I know this nothing backbone still has be I prefer the name
  Cards: {}


$(document).ready ->
  window.game = new Traders.Views.Game.Start()
  if document.body && document.body.offsetWidth
    winW = document.body.offsetWidth
    winH = document.body.offsetHeight

  if (document.compatMode=='CSS1Compat' && document.documentElement && document.documentElement.offsetWidth )
    winW = document.documentElement.offsetWidth
    winH = document.documentElement.offsetHeight

  if (window.innerWidth && window.innerHeight)
    winW = window.innerWidth
    winH = window.innerHeight

  $('#main').attr('height', winH).attr('width', winW);
  $('[name=player_name]').focus()
  true
