class Traders.Controllers.Game
  view: null
  defaults:
    round: 1
    table: null
    players: []
    player: null

  constructor: ->
    @

  setup: ->
    _.extend(@, @defaults)
    @.sounds = new Traders.Controllers.Sounds()
    @.players = new Traders.Controllers.Players
    @.players.push(new Traders.Models.Player({name: 'Player', game: @}))
    @.players.push(new Traders.Models.AI({name: 'Computer 1', game: @}))
    @.players.push(new Traders.Models.AI({name: 'Computer 2', game: @}))
    @.player = @.players[0]

    @table = []
    @table.push(@bigMoney() for i in [0...5]) for j in [0...5]
    jaws.view = new Traders.Views.Game({game: @})
    @.view = jaws.view

  update: ->
    (player.networth = player.networth * 1.0001) for player in @players
    if @players.current() != @player
      @players.current().action()
      @players.next() != @player

  draw: ->
    jaws.view.draw()

  currentPlayer: ->
    @players.current()

  fieldClicked: (row, col)->
    el = @table[row][col]
    if !el
      return false
    if el.cost
      if @currentPlayer().networth > el.cost
        @currentPlayer().networth -= el.cost
        @currentPlayer().cards.push(el.sprite)
        @table[row][col] = {}
        return true
      else
        return false

    if el.amount
      @currentPlayer().networth += el.amount
      @takeCard()
      if @isTurn()
        @players.next()
      el.sprite.remove() if el.sprite
      @table[row][col] = null
      return true
    return false

  isTurn: ->
    @players.current() == @player

  takeCard: ->
    c = Traders.Cards.Base.random()
    if @players.current().cards.length <= 5
      @players.current().cards.push new c()

  placeCard: (row, col, card) ->
    new_card = _.clone(card)
    @table[row][col] = {cost: @bigMoney(), sprite: new_card}
    @view.placeCard(row, col, new_card)
    card = null
    @currentPlayer().cards = _.compact(@currentPlayer().cards)

  bigMoney: ->
    Math.floor(Math.random()* 5000000000)
    