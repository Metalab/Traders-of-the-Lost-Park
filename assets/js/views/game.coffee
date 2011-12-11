
class Traders.Views.Game extends Backbone.View
  el: 'canvas#game'
  events: []
  game: null
  sprites: []
  table: {x: 50, y: 90, size: 64, rows: 5, cols: 5, width: 320, height: 320, rect: null}

  initialize: (opts) ->
    _.bindAll(@, 'render', 'clear', 'start', 'dragDown', 'dragUp')
    $(@.el).bind('touchstart mouseup', @dragDown)
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
    @.drawTable()
    @

  restart: ->
    @

  clear: ->
    @context.clearRect(0,0,jaws.width,jaws.height)

  draw: ->
    @clear()
    player.view.render() for player in @.game.players
    (sprite.update(); sprite.draw()) for sprite in @sprites

  gameOver: () ->
    @render()
    @renderText(['ERROR', 'Game Over!'])
    clearTimeout(@clearing)

  drawTable: ->

    for r in [0...@table.rows]
      row = @game.table[r]
      for c in [0...(@table.cols)]
        if typeof(row[c]) == "number"
          sprite = new Traders.Cards.Dollar({x: @table.x+@.table.size*c, y: @table.y+@table.size*r})
          row[c] = {amount: row[c], sprite: sprite}
          @sprites.push sprite

  drawCards: ->
    @context.save()
    @context.translate(20, 410)
    #for i in [0..(@game.player.cards.length)]
      #
    @context.restore()
    #

  dragDown: (event) ->
    if @table.rect.collidePoint(jaws.mouse_x, jaws.mouse_y)
      col = Math.floor((jaws.mouse_x - @table.x) / @table.size)
      row = Math.floor((jaws.mouse_y - @table.y) / @table.size)
      @fieldClicked(row, col)

  dragUp: (event) ->
    #

  fieldClicked: (row, col)->
    el = @game.table[row][col]
    if el.sprite
      el.sprite.remove()
      el.sprite = null
    @game.fieldClicked(row,col)
    