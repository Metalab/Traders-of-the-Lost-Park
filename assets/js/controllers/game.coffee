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
    @.players = [new Traders.Models.Player({name: 'Player'}),
      new Traders.Models.AI({name: 'Computer 1'}),
      new Traders.Models.AI({name: 'Computer 2'})]
    @.player = @.players[0]

    r = -> Math.floor(Math.random()* 5000000000)
    @table = []
    @table.push(r() for i in [0...5]) for j in [0...5]

    jaws.view = new Traders.Views.Game({game: @})
    @.view = jaws.view

  update: ->
    (player.networth = player.networth * 1.0001) for player in @players

  draw: ->
    jaws.view.draw()

  currentPlayer: ->
    @player
