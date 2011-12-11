
class Traders.Cards.Dollar
  constructor: (opts)->
    @anim = new jaws.Animation({sprite_sheet: "/images/card-dollar.png", frame_size: [64,64], frame_duration: 200})
    @sprite = new jaws.Sprite(_.extend({anchor: 'top_left'}, opts))
    return @

  update: ->
    return if @sprite == null
    @sprite.setImage(@anim.next())
    true

  draw: ->
    @sprite.draw() if @sprite

  remove: ->
    c = @sprite.context
    c.save()
    c.fillStyle = '#FFFFFF'
    c.fillRect(@sprite.rect)
    c.restore()
    @sprite = null
    