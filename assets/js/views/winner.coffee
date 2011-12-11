class Traders.Views.Winner
  @draw: (player) ->
    alert('We have a winner: ' + player.name)
    jaws.context.fillStyle = 'rgba(255,255,255,0.3)'
    jaws.context.fillRect(30, 30, 580, 400)
    jaws.context.fillStyle = '#000000'
    jaws.context.textAlign = 'center'
    jaws.context.fillText('We have a winner: ' + player.name, 120, 230)
    jaws.context.restore()
    player
