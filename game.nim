import algorithm
import ./tip
import ./board

const FIELD_SIZE = 8

type Game* = ref object
  board*: Board
  current_tip: Tip
  next_turn*: Color

proc newGame*(): Game =
  var board = newSeq[seq[Tip]](FIELD_SIZE)
  board.fill(newSeq[Tip](FIELD_SIZE))

  board[3][3] = newWhiteTip(3, 3)
  board[3][4] = newBlackTip(3, 4)
  board[4][3] = newBlackTip(4, 3)
  board[4][4] = newWhiteTip(4, 4)

  return Game(board: board, next_turn: Color.Black, current_tip: nil)

proc updateNextTurn*(game: Game): void =
  game.next_turn = if game.next_turn == Color.Black : Color.White else : Color.Black

proc updateBoard*(game: Game): void =
  let tip = game.current_tip
  game.board.updateBoard(tip)

proc canPlaceTip*(game: Game, col: int, row: int): bool =
  let tip = if game.next_turn == Color.Black: newBlackTip(col, row) else: newWhiteTip(col, row)
  return game.board.canPlaceTip(tip)
  
proc placeTip*(game: Game, col: int, row: int): void =
  let tip = if game.next_turn == Color.Black: newBlackTip(col, row) else: newWhiteTip(col, row)
  game.current_tip = tip
  game.board.placeTip(tip)

proc nextTurnIsWhite*(game: Game): bool = game.next_turn == Color.White
proc nextTurnIsBlack*(game: Game): bool = game.next_turn == Color.Black

proc isFInish*(game: Game): bool =
  for line in game.board:
    for tip in line: 
      if tip == nil: return false

  return true