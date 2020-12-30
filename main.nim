import game as othello
import player as othelloPlayer
from strformat import fmt

const INPUT_ERROR_MSG = "ILLIGAL INPUT"
const POSITION_ERROR_MSG = "ILLIGAL POSITION"

echo "-------------------------"
echo "Start game"
echo "-------------------------"
echo ""

let game = othello.newGame()
let player = othelloPlayer.createPlayer("human")

while(not game.isFInish()):
  echo "Board status:"
  game.dispBoard()

  if game.shouldSkip():
    echo fmt"Skip [ { game.getCurrentTurn() } ] turn"
    game.updateNextTurn()
    continue

  echo "example(col, row) => 1,1"
  stdout.write fmt"Input [ { game.getCurrentTurn() } ] tip:"

  let position = player.getPosition()

  if position == nil:
    echo INPUT_ERROR_MSG
    continue

  if position.col < 0 or position.col > 7:
    echo INPUT_ERROR_MSG
    continue

  if position.row < 0 or position.row > 7:
    echo INPUT_ERROR_MSG
    continue

  if game.canPlaceTip(position.col, position.row):
    game.placeTip(position.col, position.row)
    game.updateBoard()
    game.updateNextTurn()
  else:
    echo POSITION_ERROR_MSG