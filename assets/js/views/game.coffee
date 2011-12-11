
class Traders.Views.Game extends Backbone.View
  el: 'canvas#game'
  events: []
  game: null
  sprites: []
  table: {x: 50, y: 90, size: 64, rows: 5, cols: 5, width: 320, height: 320, rect: null}
  cardDragged: false

  initialize: (opts) ->
    _.bindAll(@, 'render', 'clear', 'start', 'dragDown', 'dragUp')
    $(@.el).bind('touchstart mousedown', @dragDown)
    $(@.el).bind('touchend mouseup', @dragUp)
    jaws.canvas = $(@el)

    @.game = opts.game
    @table.size = 320 / @game.table.length
    @table.rows = @game.table.length
    @table.cols = @game.table[0].length
    @table.rect = new jaws.Rect(@table.x, @table.y, @table.width, @table.height)

    @start()
    @

  start: ->
    @context = jaws.context
    @context.font = '16px Fondamento'
    pos = 0
    (new Traders.Views.Player({player: player, pos: (pos), context: @context}); pos+=1) for player in @.game.players
    @clear()
    @.createTable()
    @cards = new Traders.Views.Cards({context: @context, player: @game.player})
    @

  restart: ->
    @

  clear: ->
    @context.clearRect(0,0,jaws.width,jaws.height)

  draw: ->
    @clear()
    player.view.render() for player in @.game.players
    for tile in _.compact(_.flatten(@game.table))
      do (tile) ->
        if tile && tile.sprite
          try
            tile.sprite.update()
            tile.sprite.draw()

    @cards.draw()

  gameOver: () ->
    @render()
    @renderText(['ERROR', 'Game Over!'])
    clearTimeout(@clearing)

  createTable: ->
    for r in [0...@table.rows]
      row = @game.table[r]
      for c in [0...(@table.cols)]
        if !row[c].sprite
          @game.table[r][c].sprite = new Traders.Cards.Dollar({x: @table.x+@.table.size*c, y: @table.y+@table.size*r})

  placeCard: (row, col, card) ->
    if card.sprite
      card.sprite.moveTo(@table.x+col*@table.size, @table.y+row*@table.size)

  dragDown: (event) ->
    if @cards.rect.collidePoint(jaws.mouse_x, jaws.mouse_y)
      col = Math.floor((jaws.mouse_x - @cards.rect.x) / @cards.size)
      @cardDragged = col

  dragUp: (event) ->
    if @table.rect.collidePoint(jaws.mouse_x, jaws.mouse_y)
      col = Math.floor((jaws.mouse_x - @table.x) / @table.size)
      row = Math.floor((jaws.mouse_y - @table.y) / @table.size)
      if @cardDragged != false
        @game.placeCard(row,col, _.clone(@game.player.cards[@cardDragged]))
        @game.player.cards[@cardDragged] = null
        @cardDragged = false
      else
        @fieldClicked(row, col)
    @cardDragged = false

  fieldClicked: (row, col)->
    if ! @game.isTurn()
      return
    el = @game.table[row][col]
    @game.fieldClicked(row,col)

    