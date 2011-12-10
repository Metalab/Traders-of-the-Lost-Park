class Traders.Controllers.Game
  defaults:
    round: 1

  constructor: ->
    @

  setup: ->
    _.bindAll(@, 'removeError', 'pressed')
    @sounds = new Traders.Controllers.Sounds()
    _.extend(@, @defaults)

  draw: ->
    jaws.view.render()
