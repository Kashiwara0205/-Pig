import ./tip

const UPPER_LIMIT = 0
const RIGHT_LIMIT = 7
const LEFT_LIMIT = 0
const LOWER_LIMIT = 7

type Board* = seq[seq[Tip]]

proc outOfRange(board: Board,val: int): bool = return val < 0 or 7 < val
proc isSameColor(board: Board, tip_a: Tip, tip_b: Tip): bool = return tip_a.color == tip_b.color
proc notExistsTip(board: Board, tip: Tip): bool = return  tip == nil

proc validNextPosition(board: Board, tip: Tip, next_col: int, next_row: int): bool = 
  if board.outOfRange(next_col) or board.outOfRange(next_row): return false
  if board.notExistsTip(board[next_col][next_row]): return false
  if board.isSameColor(board[next_col][next_row], tip): return false

  return true

proc canUpdateUpper(board: Board, tip: Tip): bool =
  var col = tip.col
  var row = tip.row

  col.dec

  if not board.validNextPosition(tip, col, row): return false

  col.dec

  for i in countdown(col, UPPER_LIMIT):
    if board.notExistsTip(board[col][row]): return false
    if board.isSameColor(board[col][row], tip): return true

  return false

proc updateUpper(board: Board, tip: Tip): void =
  let col = tip.col
  let row = tip.row
  for i in countdown(col - 1, UPPER_LIMIT):
    if board.isSameColor(board[i][row], tip): break
    board[i][row].color = tip.color

proc canUpdateRight(board: Board, tip: Tip): bool =
  var col = tip.col
  var row = tip.row

  row.inc

  if not board.validNextPosition(tip, col, row): return false

  row.inc

  for i in countup(row, RIGHT_LIMIT):
    if board.notExistsTip(board[col][row]): return false
    if board.isSameColor(board[col][row], tip): return true

  return false

proc updateRight(board: Board, tip: Tip): void =
  let col = tip.col
  let row = tip.row
  for i in countup(row + 1, RIGHT_LIMIT):
    if board.isSameColor(board[col][i], tip): break
    board[col][i].color = tip.color

proc canUpdateLeft(board: Board, tip: Tip): bool =
  var col = tip.col
  var row = tip.row 

  row.dec

  if not board.validNextPosition(tip, col, row): return false

  row.dec

  for i in countdown(row , LEFT_LIMIT):
    if board.notExistsTip(board[col][row]): return false
    if board.isSameColor(board[col][row], tip): return true

  return false

proc updateLeft(board: Board, tip: Tip): void =
  let col = tip.col
  let row = tip.row
  for i in countdown(row - 1, LEFT_LIMIT):
    if board.isSameColor(board[col][i], tip): break
    board[col][i].color = tip.color

proc canUpdateLower(board: Board, tip: Tip): bool =
  var col = tip.col
  var row = tip.row

  col.inc

  if not board.validNextPosition(tip, col, row): return false

  col.inc

  for i in countup(col, LOWER_LIMIT):
    if board.notExistsTip(board[col][row]): return false
    if board.isSameColor(board[col][row], tip): return true

  return false

proc updateLower(board: Board, tip: Tip): void =
  let col = tip.col
  let row = tip.row
  for i in countup(col + 1, LOWER_LIMIT):
    if board.isSameColor(board[i][row], tip): break
    board[i][row].color = tip.color

proc canUpdateUpperRight(board: Board, tip: Tip): bool =
  var col = tip.col
  var row = tip.row

  col.dec; row.inc

  if not board.validNextPosition(tip, col, row): return false

  col.dec; row.inc

  while col >= UPPER_LIMIT and row <= RIGHT_LIMIT:
    if board.notExistsTip(board[col][row]): return false
    if board.isSameColor(board[col][row], tip): return true

    col.dec; row.inc

  return false

proc updateUpperRight(board: Board, tip: Tip): void =
  var col = tip.col
  var row = tip.row

  col.dec; row.inc

  while col >= UPPER_LIMIT and row <= RIGHT_LIMIT:
    if board.isSameColor(board[col][row], tip): break
    board[col][row].color = tip.color

    col.dec; row.inc

proc canUpdateLowerRight(board: Board, tip: Tip): bool =
  var col = tip.col
  var row = tip.row

  col.inc; row.inc

  if not board.validNextPosition(tip, col, row): return false

  col.inc; row.inc

  while col <= LOWER_LIMIT and row <= RIGHT_LIMIT:
    if board.notExistsTip(board[col][row]): return false
    if board.isSameColor(board[col][row], tip): return true

    col.inc; row.inc

  return false

proc updateLowerRight(board: Board, tip: Tip): void =
  var col = tip.col
  var row = tip.row

  col.inc; row.inc

  while col <= LOWER_LIMIT and row <= RIGHT_LIMIT:
    if board.isSameColor(board[col][row], tip): break
    board[col][row].color = tip.color

    col.inc; row.inc

proc canUpdateUpperLeft(board: Board, tip: Tip): bool =
  var col = tip.col
  var row = tip.row

  col.dec; row.dec

  if not board.validNextPosition(tip, col, row): return false

  col.dec; row.dec

  while col >= UPPER_LIMIT and row >= LEFT_LIMIT:
    if board.notExistsTip(board[col][row]): return false
    if board.isSameColor(board[col][row], tip): return true

    col.dec; row.dec

  return false

proc updateUpperLeft(board: Board, tip: Tip): void =
  var col = tip.col
  var row = tip.row

  col.dec; row.dec

  while col >= UPPER_LIMIT and row >= LEFT_LIMIT:
    if board.isSameColor(board[col][row], tip): break
    board[col][row].color = tip.color

    col.dec; row.dec

proc canUpdateLowerLeft(board: Board, tip: Tip): bool =
  var col = tip.col
  var row = tip.row

  col.inc; row.dec

  if not board.validNextPosition(tip, col, row): return false

  col.inc; row.dec

  while col <= LOWER_LIMIT and row >= LEFT_LIMIT:
    if board.notExistsTip(board[col][row]): return false
    if board.isSameColor(board[col][row], tip): return true

    col.inc; row.dec

  return false

proc updateLowerLeft(board: Board, tip: Tip): void =
  var col = tip.col
  var row = tip.row

  col.inc; row.dec

  while col <= LOWER_LIMIT and row >= LEFT_LIMIT:
    if board.isSameColor(board[col][row], tip): break
    board[col][row].color = tip.color

    col.inc; row.dec

proc positionIsEmpty(board: Board, tip: Tip): bool =
  return board[tip.col][tip.row] == nil

proc updateBoard*(board: Board, tip: Tip): void =
  if board.canUpdateUpper(tip): board.updateUpper(tip)
  if board.canUpdateRight(tip): board.updateRight(tip)
  if board.canUpdateLeft(tip): board.updateLeft(tip)
  if board.canUpdateLower(tip): board.updateLower(tip)
  if board.canUpdateUpperRight(tip): board.updateUpperRight(tip)
  if board.canUpdateLowerRight(tip): board.updateLowerRight(tip)
  if board.canUpdateUpperLeft(tip): board.updateUpperLeft(tip)
  if board.canUpdateLowerLeft(tip): board.updateLowerLeft(tip)

proc canPlaceTip*(board: Board, tip: Tip): bool = 
  return board.positionIsEmpty(tip) and(
         board.canUpdateUpper(tip) or
         board.canUpdateRight(tip) or
         board.canUpdateLeft(tip) or
         board.canUpdateLower(tip) or
         board.canUpdateUpperRight(tip) or
         board.canUpdateLowerRight(tip) or
         board.canUpdateUpperLeft(tip) or
         board.canUpdateLowerLeft(tip) )

proc shouldSkip*(board: Board, color: Color): bool = 
  for col, line in board:
    for row, current_tip in line:
      let tip  = if color == Color.Black: newBlackTip(col, row) else: newWhiteTip(col, row)
      if board.canPlaceTip(tip): return false
  return true

proc placeTip*(board: var Board, tip: Tip): void =
  board[tip.col][tip.row] = tip