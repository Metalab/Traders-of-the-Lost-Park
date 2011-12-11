class Traders.Models.Player extends Backbone.Model
  name: 'Player'
  networth: 0.1
  cards: null

  constructor: (opts) ->
    @cards = []
    _.extend(@, opts)

  action: ->
    #
  winByCards: ->
    if @cards.length == 5
      name = @cards[0].name
      for i in [1...@cards.length]
        return false if @cards[i].name != name
      return true