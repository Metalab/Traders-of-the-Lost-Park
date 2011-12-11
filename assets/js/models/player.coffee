class Traders.Models.Player extends Backbone.Model
  name: 'Player'
  networth: 0.1
  cards: null

  constructor: (opts) ->
    @cards = []
    _.extend(@, opts)

  action: ->
    #