#= require 'base'
Traders.Cards.Personae ||= {}

class Traders.Cards.Personae.Phil extends Traders.Cards.Personae.Base
  name: 'Phil A. N. Trouphique'
  networth: 3000000000
  description: 'Loves taxes, give plenty but still grows in worth.'
  conditions: 'Spend all your money or help the protesters to stay for at least 15 rounds'

  conditionsSatisfied: ->
    @.game.round >= 15 ||
    @.networth < 1
