import algorithm
import ./tip
import ./board
from strformat import fmt

const FIELD_SIZE = 8

const BLACK_TIP = " ○ "
const WHITE_TIP = " ● "
const NO_TIP = "   "

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
  game.next_turn = if game.next_turn == Color.Black: Color.White else: Color.Black

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

proc shouldSkip*(game: Game): bool =
  return game.board.shouldSkip(game.next_turn)

proc nextTurnIsWhite(game: Game): bool = game.next_turn == Color.White
proc nextTurnIsBlack(game: Game): bool = game.next_turn == Color.Black

proc isFInish*(game: Game): bool =
  for line in game.board:
    for tip in line: 
      if tip == nil: return false

  return true

proc getTipStr(game: Game, tip: Tip): string =
  if tip == nil: return NO_TIP
  if tip.color == Color.Black: return BLACK_TIP else: return WHITE_TIP

proc dispBoard*(game: Game): void =
  for i in (0..7): stdout.write fmt"  {i} "
  echo ""
  for i, line in game.board:
    stdout.write(i)
    for tip in line: 
      stdout.write game.getTipStr(tip) & "|"
    echo ""
  echo ""

proc calcBlackTip*(game: Game): int =
  var cnt = 0
  for line in game.board:
    for tip in line: 
      if tip.color == Color.Black:
        cnt.inc

  return cnt

proc calcWhiteTip*(game: Game): int =
  var cnt = 0
  for line in game.board:
    for tip in line: 
      if tip.color == Color.White:
        cnt.inc

  return cnt
proc getCurrentTurn*(game: Game):string =
  if game.nextTurnIsBlack(): return "Black"
  if game.nextTurnIsWhite(): return "White"