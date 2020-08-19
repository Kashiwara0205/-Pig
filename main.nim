import algorithm
import ./tip
import ./board

const FIELD_SIZE = 8

type Game* = ref object
  board*: Board

proc newGame*(): Game =
  var board = newSeq[seq[Tip]](FIELD_SIZE)
  board.fill(newSeq[Tip](FIELD_SIZE))

  board[3][3] = newWhiteTip(3, 3)
  board[3][4] = newBlackTip(3, 4)
  board[4][3] = newBlackTip(4, 3)
  board[4][4] = newWhiteTip(4, 4)

  return Game(board: board)

proc placeTip(game: Game, tip: Tip): void =
  let col = tip.col
  let row = tip.row
  game.board[col][row] = tip
  game.board.updateBoard(tip)

proc placeWhiteTip*(game: Game, col: int, row: int): void = game.placeTip(newWhiteTip(col, row))
proc placeBlackTip*(game: Game, col: int, row: int): void = game.placeTip(newBlackTip(col, row))