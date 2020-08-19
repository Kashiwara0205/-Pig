import game as othello
import main_helper

const INPUT_ERROR_MSG = "ILLIGAL INPUT"
const POSITION_ERROR_MSG = "ILLIGAL POSITION"

echo "Start game"
let game = othello.newGame()

while(not game.isFInish()):
  if game.nextTurnIsBlack(): echo "Input [ Black ] tip: (col, row)"
  if game.nextTurnIsWhite(): echo "Input [ White ] tip: (col, row)"

  let input_str = readLine(stdin)
  if input_str == "q": break
  let position = genPosition(input_str)

  if position == nil:
    echo INPUT_ERROR_MSG
    continue

  if game.canPlaceTip(position.col, position.row):
    game.placeTip(position.col, position.row)
    game.updateBoard()
    game.updateNextTurn()
  else:
    echo POSITION_ERROR_MSG