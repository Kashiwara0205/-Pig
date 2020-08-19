import game as othello
import main_helper

const INPUT_ERROR_MSG = "ILLIGAL INPUT"
const POSITION_ERROR_MSG = "ILLIGAL POSITION"

echo "Start game"
echo ""
let game = othello.newGame()

while(not game.isFInish()):
  echo "Board status:"
  game.dispBoard()

  echo "example(col, row) => 1,1"
  if game.nextTurnIsBlack(): stdout.write "Input [ Black ] tip:"
  if game.nextTurnIsWhite(): stdout.write "Input [ White ] tip:"

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