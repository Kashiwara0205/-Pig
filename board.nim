import ./tip

const UPPER_LIMIT = 0
const RIGHT_LIMIT = 7
const LEFT_LIMIT = 0
const LOWER_LIMIT = 7

type Board* = seq[seq[Tip]]

proc canUpdateUpper(board: Board, tip: Tip): bool =
  let col = tip.col
  let row = tip.row
  for i in countdown(col - 1, UPPER_LIMIT):
    if board[i][row] == nil: return false
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
  for i in countup(row + 1, RIGHT_LIMIT):
    if board[col][i] == nil: return false
    if board[col][i].color == tip.color: return true

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
  for i in countdown(row - 1, LEFT_LIMIT):
    if board[col][i] == nil: return false
    if board[col][i].color == tip.color: return true

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
  for i in countup(col + 1, LOWER_LIMIT):
    if board[i][row] == nil: return false
    if board[i][row].color == tip.color: return true

  return false

proc updateLower(board: Board, tip: Tip): void =
  if not board.canUpdateLower(tip): return
  let col = tip.col
  let row = tip.row
  for i in countup(col + 1, LOWER_LIMIT):
    if board[i][row].color == tip.color: break
    board[i][row].color = tip.color

proc canUpdateUpperRight(board: Board, tip: Tip): bool =
  var col = tip.col
  var row = tip.row

  col.dec
  row.inc

  while col >= UPPER_LIMIT and row <= RIGHT_LIMIT:
    if board[col][row] == nil: return false
    if board[col][row].color == tip.color: return true
    col.dec
    row.inc

  return false

proc updateUpperRight(board: Board, tip: Tip): void =
  if not board.canUpdateUpperRight(tip): return
  var col = tip.col
  var row = tip.row

  col.dec
  row.inc

  while col >= UPPER_LIMIT and row <= RIGHT_LIMIT:
    if board[col][row].color == tip.color: break
    board[col][row].color = tip.color
    col.dec
    row.inc

proc canUpdateLowerRight(board: Board, tip: Tip): bool =
  var col = tip.col
  var row = tip.row

  col.inc
  row.inc

  while col <= LOWER_LIMIT and row <= RIGHT_LIMIT:
    if board[col][row] == nil: return false
    if board[col][row].color == tip.color: return true
    col.inc
    row.inc

  return false

proc updateLowerRight(board: Board, tip: Tip): void =
  if not board.canUpdateLowerRight(tip): return
  var col = tip.col
  var row = tip.row

  col.inc
  row.inc

  while col <= LOWER_LIMIT and row <= RIGHT_LIMIT:
    if board[col][row].color == tip.color: break
    board[col][row].color = tip.color
    col.inc
    row.inc

proc updateBoard*(board: Board, tip: Tip): void =
  board.updateUpper(tip)
  board.updateRight(tip)
  board.updateLeft(tip)
  board.updateLower(tip)
  board.updateUpperRight(tip)
  board.updateLowerRight(tip)
