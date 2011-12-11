class Traders.Models.AI extends Backbone.Model
  name: 'Computer'
  networth: 0

  initialize: (opts) ->
    _.extend(@, opts)
    @

  action: ->
    r = (s) -> Math.floor(Math.random() * s);
    @game.fieldClicked(r(@game.table.length), r(@game.table.length))