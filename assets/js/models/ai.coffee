#= require 'player'
class Traders.Models.AI extends Traders.Models.Player
  name: 'Computer'

  action: ->
    r = (s) -> Math.floor(Math.random() * s);
    if @cards.length > 0
    else
      @game.takeCard()
      @game.fieldClicked(r(@game.table.length), r(@game.table.length))
