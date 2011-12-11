
class Traders.Views.Cards
  player: null
  context: null
  rect: {x: 20, y: 420}
  size: 64

  constructor: (opts)->
    _.extend(@, opts)

  draw: ->
    for i in [0...(@cards().length)]
      c = @card(i)
      c.sprite.moveTo(@rect.x+(i*@size), @rect.y)
      c.update()
      c.draw()
    #

  card: (i) ->
    @cards()[i]

  cards: ->
    _.compact(@player.cards)