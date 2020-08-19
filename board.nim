import ./tip

const UPPER_LIMIT = 0
const RIGHT_LIMIT = 7
const LEFT_LIMIT = 0
const LOWER_LIMIT = 7

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

proc updateBoard*(board: Board, tip: Tip): void =
  board.updateUpper(tip)
  board.updateRight(tip)
  board.updateLeft(tip)
  board.updateLower(tip)
