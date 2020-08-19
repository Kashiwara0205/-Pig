import game as othello
import strutils
import sequtils, sugar

proc getPosition(input_str: TaintedString): (int, int) =
  var text = input_str
  let arr = text.replace(" ", "").split(',').map(x => x.parseInt)

  return (arr[0], arr[1])

let game = othello.newGame()
echo "Start game"
while(not game.isFInish()):
  if game.nextTurnIsBlack(): echo "Input [ Black ] tip: (col, row)"
  if game.nextTurnIsWhite(): echo "Input [ White ] tip: (col, row)"
  let input_str = readLine(stdin)
  if input_str == "q": break
  let position = getPosition(input_str)
  game.placeTip(position[0], position[1])
  game.updateBoard()
  game.updateNextTurn()