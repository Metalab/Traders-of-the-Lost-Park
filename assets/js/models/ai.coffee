class Traders.Models.AI extends Backbone.Model
  name: 'Computer'
  networth: 0

  initialize: (opts) ->
    _.extend(@, opts)
    @

  action: ->
    console.log(@name);