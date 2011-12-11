class Traders.Controllers.Players extends Array
  pos: 0

  current: ->
    @[@pos]

  next: ->
    @pos += 1
    if @pos >= @.length
      @pos = 0
    @current()