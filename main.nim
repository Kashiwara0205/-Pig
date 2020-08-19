import algorithm

const FIELD_SIZE = 8

const UPPER_LIMIT = 0
const RIGHT_LIMIT = 7
const LEFT_LIMIT = 0
const LOWER_LIMIT = 7

type Color* {.pure.} = enum
  White, Black

type Tip* = ref object
  color: Color

proc newWhiteTip(): Tip = return Tip(color: Color.White)
proc newBlackTip(): Tip = return Tip(color: Color.Black)

type Board* = seq[seq[Tip]]

proc canUpdateUpper(board: Board, col: int, row: int, tip: Tip): bool =
  if col == UPPER_LIMIT: return false
  let next_tip = board[col - 1][row]
  if next_tip == nil or tip.color == next_tip.color: return false
  for i in countdown(col - 1, UPPER_LIMIT):
    if board[i][row].color == tip.color: return true

  return false

proc updateUpper(board: Board, col: int, row: int, tip: Tip): void =
  if not board.canUpdateUpper(col, row, tip): return 
  for i in countdown(col - 1, UPPER_LIMIT):
    if board[i][row].color == tip.color: break
    board[i][row].color = tip.color

proc updateRight(board: Board, col: int, row: int, tip: Tip): void =
  if row == RIGHT_LIMIT: return
  let next_tip = board[col][row + 1]
  if next_tip == nil or tip.color == next_tip.color: return

  for i in countup(row + 1, RIGHT_LIMIT):
    if board[col][i].color == tip.color: break
    board[col][i].color = tip.color

proc updateLeft(board: Board, col: int, row: int, tip: Tip): void =
  if row == LEFT_LIMIT: return
  let next_tip = board[col][row - 1]
  if next_tip == nil or tip.color == next_tip.color: return

  for i in countdown(row - 1, LEFT_LIMIT):
    if board[col][i].color == tip.color: break
    board[col][i].color = tip.color

proc updateLower(board: Board, col: int, row: int, tip: Tip): void =
  if row == LOWER_LIMIT: return
  let next_tip = board[col + 1][row]
  if next_tip == nil or tip.color == next_tip.color: return

  for i in countup(col + 1, LOWER_LIMIT):
    if board[i][row].color == tip.color: break
    board[i][row].color = tip.color

proc updateBoard(board: Board, col: int, row: int, tip: Tip): void =
  board.updateUpper(col, row, tip)
  board.updateRight(col, row, tip)
  board.updateLeft(col, row, tip)
  board.updateLower(col, row, tip)

type Game* = ref object
  board: Board

proc newGame*(): Game =
  var board = newSeq[seq[Tip]](FIELD_SIZE)
  board.fill(newSeq[Tip](FIELD_SIZE))

  board[3][3] = newWhiteTip()
  board[3][4] = newBlackTip()
  board[4][3] = newBlackTip()
  board[4][4] = newWhiteTip()

  return Game(board: board)

proc placeTip(game: Game, col: int, row: int, tip: Tip): void =
  game.board[col][row] = tip
  game.board.updateBoard(col, row, tip)

proc placeWhiteTip*(game: Game, col: int, row: int): void = game.placeTip(col, row, newWhiteTip())
proc placeBlackTip*(game: Game, col: int, row: int): void = game.placeTip(col, row, newBlackTip())

block test:
  block should_make_new_game:
    let game = newGame()
    assert game.board[3][3].color == Color.White
    assert game.board[3][4].color == Color.Black
    assert game.board[4][3].color == Color.Black
    assert game.board[4][4].color == Color.White
  block should_reverse_uppder:
    let game = newGame()
    game.placeBlackTip(5, 4)
    assert game.board[4][3].color == Color.Black
    assert game.board[4][4].color == Color.Black
    assert game.board[5][4].color == Color.Black
  block should_reverse_right:
    let game = newGame()
    game.placeBlackTip(2, 3)
    assert game.board[2][3].color == Color.Black
    assert game.board[3][3].color == Color.Black
    assert game.board[4][3].color == Color.Black
  block should_reverse_left:
    let game = newGame()
    game.placeBlackTip(4, 5)
    assert game.board[4][3].color == Color.Black
    assert game.board[4][4].color == Color.Black
    assert game.board[4][5].color == Color.Black
  block should_reverse_lower:
    let game = newGame()
    game.placeBlackTip(2, 3)
    assert game.board[2][3].color == Color.Black
    assert game.board[3][3].color == Color.Black
    assert game.board[4][3].color == Color.Black