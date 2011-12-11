#= require 'player'
class Traders.Models.AI extends Traders.Models.Player
  name: 'Computer'

  action: ->
    r = (s) -> Math.floor(Math.random() * s);
    row = r(@game.table.length)
    col = r(@game.table.length)
    if ! @game.fieldClicked(row, col)
      if @cards.length > 0
        @game.placeCard(row, col, @cards[Math.floor(Math.random()*@cards.length)])
