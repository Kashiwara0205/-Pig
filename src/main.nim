import game as reversi
import player as reversiPlayer
from strformat import fmt

const INPUT_ERROR_MSG = "ILLIGAL INPUT"
const POSITION_ERROR_MSG = "ILLIGAL POSITION"

echo ""
echo "----------------------------"
echo "Introductions"
echo ""
echo "This is simple Reversi game"
echo "Ctrl+C: finish this game"
echo "----------------------------"
echo ""

let game = reversi.newGame()
let player = reversiPlayer.createPlayer("human")

proc ctrlc() {.noconv.} = system.quit(QuitSuccess)

while(not game.isFInish()):
  echo ""
  game.dispBoard()
  echo ""
  setControlCHook(ctrlc)

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

let blackTipCnt = game.calcBlackTip()
let whiteTipCnt = game.calcWhiteTip()

echo "[ FINAL RESULT ] "
echo "--------------------------------------------"
echo ""
game.dispBoard()
echo "--------------------------------------------"
echo fmt"Black tip is  [ { blackTipCnt } ]"
echo fmt"White tip is  [ { whiteTipCnt } ]"

if blackTipCnt > whiteTipCnt:
  echo "Black wins"
elif whiteTipCnt > blackTipCnt:
  echo "White wins"
else:
  echo "Draw"