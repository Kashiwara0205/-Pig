import strutils
import sequtils, sugar

type Position = ref object
  col*: int
  row*: int

type Player = ref object of RootObj
method getPosition*(player: Player): Position {.base, locks: "unknown".} = discard

type Cpu = ref object of Player
method getPosition*(player: Cpu): Position {.locks: "unknown".} =  discard

type Human = ref object of Player
method getPosition*(player: Human): Position {.locks: "unknown".} =
  var input_str = readLine(stdin)
  try:
    var text = input_str
    if text == "q": system.quit(QuitSuccess)
    let arr = text.replace(" ", "").split(',').map(x => x.parseInt)
    return Position(col: arr[0], row: arr[1])
  except:
    return nil

proc create*(name: string): Player =
  if "cpu" == name: return Cpu()
  if "human" == name: return Human()