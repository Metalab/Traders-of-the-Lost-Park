Traders.Cards.Personae ||= {}

class Traders.Cards.Personae.Monty extends Traders.Cards.Personae.Base
  name: 'Montgomery McRich'
  networth: 3000000000
  description: 'Old irish money, defend it, grow it'
  conditions: 'Control more than five police forces or grow your networth to five billion'

  conditionsSatisfied: ->
    @.networth > 5000000 ||
    _.filter(@.minions, (m) -> m.force == 'police') > 5
