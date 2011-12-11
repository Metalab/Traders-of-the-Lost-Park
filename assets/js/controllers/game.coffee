class Traders.Controllers.Game
  view: null
  defaults:
    round: 1
    table: null
    players: []
    player: null
    dollars_left: true

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
    @table.push({amount: @bigMoney()} for i in [0...5]) for j in [0...5]
    @dollars_left = 25
    jaws.view = new Traders.Views.Game({game: @})
    @.view = jaws.view

  update: ->
    return if @winner
    if @dollars_left == 0
      @winner = @players[0]
      (if @winner.networth < player.networth then @winner = player) for player in @players
      Traders.Views.Winner.draw(@winner)
      jaws.game_loop.stop()
    if @currentPlayer().winByCards()
      @winner = @currentPlayer()
      Traders.Views.Winner.draw(@currentPlayer())
      jaws.game_loop.stop()
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
      if @isTurn()
        @sounds.play('error')
      return false
    if el.cost
      if @currentPlayer().networth > el.cost && @currentPlayer().cards.length < 5
        @currentPlayer().networth -= el.cost
        @currentPlayer().cards.push(el.sprite)
        @table[row][col] = {}
        @sounds.play('tile')
        return true
      else
        if @isTurn()
          @sounds.play('error')
        return false

    if el.amount
      @dollars_left -= 1
      @currentPlayer().networth += el.amount
      @takeCard()
      if @isTurn()
        @players.next()
      el.sprite.clear()
      el.sprite = null
      el.amount = null
      @table[row][col] = null
      @sounds.play('money')
      return true
    if @isTurn()
      @sounds.play('error')
    return false

  isTurn: ->
    @players.current() == @player

  takeCard: ->
    c = Traders.Cards.Base.random()
    if @players.current().cards.length < 5
      @players.current().cards.push new c()

  placeCard: (row, col, card) ->
    new_card = _.clone(card)
    @table[row][col] = {cost: @bigMoney(), sprite: new_card}
    @view.placeCard(row, col, new_card)
    @currentPlayer().cards = _.compact(@currentPlayer().cards)
    if @isTurn()
      @players.next()

  bigMoney: ->
    Math.floor(Math.random()* 5000)
    