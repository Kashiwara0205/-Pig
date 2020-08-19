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
  col: int
  row: int

proc newWhiteTip(col: int, row: int): Tip = return Tip(color: Color.White, col: col, row: row)
proc newBlackTip(col: int, row: int): Tip = return Tip(color: Color.Black, col: col, row: row)

type Board* = seq[seq[Tip]]

proc canUpdateUpper(board: Board, tip: Tip): bool =
  let col = tip.col
  let row = tip.row
  if col == UPPER_LIMIT: return false
  let next_tip = board[col - 1][row]
  if next_tip == nil or tip.color == next_tip.color: return false
  for i in countdown(col - 1, UPPER_LIMIT):
    if board[i][row].color == tip.color: return true

  return false

proc updateUpper(board: Board, tip: Tip): void =
  if not board.canUpdateUpper(tip): return 
  let col = tip.col
  let row = tip.row
  for i in countdown(col - 1, UPPER_LIMIT):
    if board[i][row].color == tip.color: break
    board[i][row].color = tip.color

proc canUpdateRight(board: Board, tip: Tip): bool =
  let col = tip.col
  let row = tip.row
  if row == RIGHT_LIMIT: return false
  let next_tip = board[col][row + 1]
  if next_tip == nil or tip.color == next_tip.color: return false

  for i in countup(row + 1, RIGHT_LIMIT):
    if board[col][i].color == tip.color: return true
    board[col][i].color = tip.color

  return false

proc updateRight(board: Board, tip: Tip): void =
  if not board.canUpdateRight(tip): return
  let col = tip.col
  let row = tip.row
  if row == RIGHT_LIMIT: return
  let next_tip = board[col][row + 1]
  if next_tip == nil or tip.color == next_tip.color: return

  for i in countup(row + 1, RIGHT_LIMIT):
    if board[col][i].color == tip.color: break
    board[col][i].color = tip.color

proc canUpdateLeft(board: Board, tip: Tip): bool =
  let col = tip.col
  let row = tip.row
  if row == LEFT_LIMIT: return false
  let next_tip = board[col][row - 1]
  if next_tip == nil or tip.color == next_tip.color: return false

  for i in countdown(row - 1, LEFT_LIMIT):
    if board[col][i].color == tip.color: return true
    board[col][i].color = tip.color

  return false

proc updateLeft(board: Board, tip: Tip): void =
  if not board.canUpdateLeft(tip): return
  let col = tip.col
  let row = tip.row
  for i in countdown(row - 1, LEFT_LIMIT):
    if board[col][i].color == tip.color: break
    board[col][i].color = tip.color

proc canUpdateLower(board: Board, tip: Tip): bool =
  let col = tip.col
  let row = tip.row
  if row == LOWER_LIMIT: return false
  let next_tip = board[col + 1][row]
  if next_tip == nil or tip.color == next_tip.color: return false

  for i in countup(col + 1, LOWER_LIMIT):
    if board[i][row].color == tip.color: return true
    board[i][row].color = tip.color

  return false

proc updateLower(board: Board, tip: Tip): void =
  if not board.canUpdateLower(tip): return
  let col = tip.col
  let row = tip.row
  for i in countup(col + 1, LOWER_LIMIT):
    if board[i][row].color == tip.color: break
    board[i][row].color = tip.color

proc updateBoard(board: Board, tip: Tip): void =
  board.updateUpper(tip)
  board.updateRight(tip)
  board.updateLeft(tip)
  board.updateLower(tip)

type Game* = ref object
  board: Board

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