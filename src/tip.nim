type Color* {.pure.} = enum
  White, Black

type Tip* = ref object
  color*: Color
  col*: int
  row*: int

proc newWhiteTip*(col: int, row: int): Tip = return Tip(color: Color.White, col: col, row: row)
proc newBlackTip*(col: int, row: int): Tip = return Tip(color: Color.Black, col: col, row: row)