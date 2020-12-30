import strutils
import sequtils, sugar

type Position* = ref object
  col*: int
  row*: int

type Player = ref object
proc getPosition*(player: Player): Position =
  var input_str = readLine(stdin)
  try:
    var text = input_str
    if text == "q": system.quit(QuitSuccess)
    let arr = text.replace(" ", "").split(',').map(x => x.parseInt)
    return Position(col: arr[0], row: arr[1])
  except:
    return nil

func createPlayer*(name: string): Player = return Player()