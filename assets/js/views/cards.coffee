
class Traders.Views.Cards
  player: null
  context: null
  rect: new jaws.Rect(20, 420, 0, 0)
  size: 64

  constructor: (opts)->
    _.extend(@, opts)

  draw: ->
    @rect.resizeTo(@size * @cards().length, @size)
    @context.save()
    @context.fillStyle = '#DDDDDD'
    @context.fillRect(@rect.x, @rect.y, 5*@size, @size)
    @context.restore()
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