class Traders.Controllers.Sounds
  effects:
    error: ["square",0,0.4000,0,0.0380,0.1830,0.0740,20,948,2400,-0.5340,0,0,0.0100,0.0003,0,0,0,0.5000,-0.4460,0,0,0,1,0,0,0.0770,0]

  constructor: ->
    @samples = jsfxlib.createWaves(@effects);
    return @
  play: (effect) ->
    e = @samples[effect]
    e.play()