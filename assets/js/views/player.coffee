
class Traders.Views.Player extends Backbone.View
  tag: 'div'
  player: null
  context: null
  pos: 0

  initialize: (opts)->
    _.extend(@, opts)
    opts.player.view = @
    @.color = ["#FFAAAA", "#AAFFAA", "#AAAAFF", "#FFFFAA", '#AAFFFF'][@pos]
    @

  render: ->
    w = 140
    h = 50
    x = ((@pos * w) % jaws.height)
    y = 10 + (Math.floor(@pos / jaws.height) * h)
    @.context.save()
    @.context.translate(x+2,y+2)
    @.context.strokeStyle = "black"
    @.context.strokeRect(0, 0, w-10, h)
    @.context.fillStyle = @color
    @.context.fillRect(0, 0, w-10, h)
    @.context.fillStyle = "black"
    @.context.fillText(@player.name, 5, h/2-5)
    @.context.translate(0,h-10)
    @.context.textAlign = 'right'
    @.context.fillText("$M " + Math.floor(@player.networth/100) * 100, w-20, 0)
    @.context.restore()
