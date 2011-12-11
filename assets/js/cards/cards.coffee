Traders.Cards ||= {}

$(document).ready ->
  Traders.Cards.Base.minions = [
    Traders.Cards.Minions.Police,
    Traders.Cards.Minions.Protester,
    Traders.Cards.Minions.Media]

class Traders.Cards.Base

  @random: ->
     return @minions[Math.floor(Math.random()*(@minions.length))]

  constructor: (opts) ->
    @setup(opts)

  setup: (opts)->
    @anim = new jaws.Animation({sprite_sheet: @image, frame_size: @frame_size, frame_duration: 200})
    @sprite = new jaws.Sprite(_.extend({anchor: 'top_left'}, opts))
    return @

  update: ->
    return if @sprite == null
    @sprite.setImage(@anim.next())
    true

  draw: ->
    @sprite.draw() if @sprite

  remove: ->
    if !@sprite
      return
    c = @sprite.context
    c.save()
    c.fillStyle = '#FFFFFF'
    c.fillRect(@sprite.rect)
    c.restore()
    @sprite = null
