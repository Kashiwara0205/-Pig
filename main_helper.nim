import strutils
import sequtils, sugar

type Position = ref object
  col*: int
  row*: int

proc genPosition*(input_str: TaintedString): Position =
  try:
    var text = input_str
    let arr = text.replace(" ", "").split(',').map(x => x.parseInt)

    return Position(col: arr[0], row: arr[1])
  except:
    return nil