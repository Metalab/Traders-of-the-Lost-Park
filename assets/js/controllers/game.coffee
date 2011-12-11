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
    @.players.push(new Traders.Models.Player({name: 'Player'}))
    @.players.push(new Traders.Models.AI({name: 'Computer 1'}))
    @.players.push(new Traders.Models.AI({name: 'Computer 2'}))
    @.player = @.players[0]

    r = -> Math.floor(Math.random()* 5000000000)
    @table = []
    @table.push(r() for i in [0...5]) for j in [0...5]

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
    if @players.current() != @player
      return false
    el =  @table[row][col]
    if el.amount
      @player.networth += el.amount
      el.amount = 0
    @players.next()
    