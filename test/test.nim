import ../src/tip
import ../src/board
import ../src/game

# for test 
proc placeTipMock(game: Game, tip: Tip): void =
  let col = tip.col
  let row = tip.row
  game.board[col][row] = tip
  game.board.updateBoard(tip)

proc deleteAllTip(game: Game): void = 
  for col, line in game.board:
    for row, current_tip in line:
      game.board[col][row] = nil

proc placeWhiteTip(game: Game, col: int, row: int): void = game.placeTipMock(newWhiteTip(col, row))
proc placeBlackTip(game: Game, col: int, row: int): void = game.placeTipMock(newBlackTip(col, row))

block test:

  block test_new_game:

    # outline: should_make_new_game
    # expected: expected initiali reversi position
    var game = newGame()
    assert game.board[3][3].color == Color.White
    assert game.board[3][4].color == Color.Black
    assert game.board[4][3].color == Color.Black
    assert game.board[4][4].color == Color.White

  block test_can_place_tip:

    # outline: should_return_expected_bool_when_can_update_upper
    # expected: if position is (5, 4) then return true
    #           if position is (4, 4) then return false
    var game = newGame()
    assert game.canPlaceTip(5, 4)
    assert not game.canPlaceTip(4, 4)

    # outline: should_return_expected_bool_when_can_update_right
    # expected: if position is (5, 4) then return true
    #           if position is (2, 4) then return false
    game = newGame()
    assert game.canPlaceTip(2, 3)
    assert not game.canPlaceTip(2, 4)

    # outline: should_return_expected_bool_when_can_update_left
    # expected: if position is (4, 5) then return true
    #           if position is (3, 5) then return false
    game = newGame()
    assert game.canPlaceTip(4, 5)
    assert not game.canPlaceTip(3, 5)

    # outline: should_return_expected_bool_when_can_update_lower
    # expected: if position is (2, 3) then return true
    #           if position is (1, 3) then return false
    game = newGame()
    assert game.canPlaceTip(2, 3)
    assert not game.canPlaceTip(1, 3)

    # outline: should_return_expected_bool_when_can_update_upper_right
    # expected: if position is (5, 2) then return true
    #           if position is (6, 1) then return false
    game = newGame()
    game.placeWhiteTip(5, 3)
    assert game.canPlaceTip(5, 2)
    assert not game.canPlaceTip(6, 1)

    # outline: should_return_expected_bool_when_can_update_lower_right
    # expected: if position is (2, 2) then return true
    #           if position is (1, 1) then return false
    game = newGame()
    game.placeBlackTip(2, 3)
    game.updateNextTurn()
    assert game.canPlaceTip(2, 2)
    assert not game.canPlaceTip(1, 1)

    # outline: should_return_expected_bool_when_can_update_upper_left
    # expected: if position is (5, 5) then return true
    #           if position is (4, 4) then return false
    game = newGame()
    game.placeBlackTip(5, 4)
    game.updateNextTurn()
    assert game.canPlaceTip(5, 5)
    assert not game.canPlaceTip(4, 4)

    # outline: should_return_expected_bool_when_can_update_lower_left
    # expected: if position is (2, 2) then return true
    #           if position is (3, 1) then return false
    game = newGame()
    game.placeBlackTip(2, 3)
    game.updateNextTurn()
    assert game.canPlaceTip(2, 2)
    assert not game.canPlaceTip(3, 1)

  block test_update:

    # outline: should_reverse_upper
    # expected: update tips to black color
    var game = newGame()
    game.placeBlackTip(5, 4)
    assert game.board[4][3].color == Color.Black
    assert game.board[4][4].color == Color.Black
    assert game.board[5][4].color == Color.Black

    # outline: should_reverse_right
    # expected: update tips to black color
    game = newGame()
    game.placeBlackTip(2, 3)
    assert game.board[2][3].color == Color.Black
    assert game.board[3][3].color == Color.Black
    assert game.board[4][3].color == Color.Black


    # outline: should_reverse_left
    # expected: update tips to black color
    game = newGame()
    game.placeBlackTip(4, 5)
    assert game.board[4][3].color == Color.Black
    assert game.board[4][4].color == Color.Black
    assert game.board[4][5].color == Color.Black

    # outline: should_reverse_lower
    # expected: update tips to black color
    game = newGame()
    game.placeBlackTip(2, 3)
    assert game.board[2][3].color == Color.Black
    assert game.board[3][3].color == Color.Black
    assert game.board[4][3].color == Color.Black

    # outline: should_reverse_upper_right
    # expected: update tips to black color
    game = newGame()
    game.placeWhiteTip(5, 3)
    assert game.board[4][3].color == Color.White
    game.placeBlackTip(5, 2)
    assert game.board[5][2].color == Color.Black
    assert game.board[4][3].color == Color.Black
    assert game.board[3][4].color == Color.Black

    # outline: should_reverse_lower_right
    # expected: update tips to white color
    game = newGame()
    game.placeBlackTip(2, 3)
    assert game.board[3][3].color == Color.Black
    game.placeWhiteTip(2, 2)
    assert game.board[2][2].color == Color.White
    assert game.board[3][3].color == Color.White
    assert game.board[4][4].color == Color.White

    # outline: should_reverse_upper_left
    # expected: update tips to white color
    game = newGame()
    game.placeBlackTip(5, 4)
    assert game.board[4][4].color == Color.Black
    game.placeWhiteTip(5, 5)
    assert game.board[5][5].color == Color.White
    assert game.board[4][4].color == Color.White
    assert game.board[3][3].color == Color.White

    # outline: should_reverse_lower_left
    # expected: update tips to white color
    game = newGame()
    game.placeBlackTip(2, 3)
    assert game.board[3][3].color == Color.Black
    game.placeWhiteTip(2, 2)
    assert game.board[2][2].color == Color.White
    assert game.board[3][3].color == Color.White
    assert game.board[4][4].color == Color.White

  block test_max_range_update:

    # outline: should update max range of upper 
    # expected: update tips to black color
    var game = newGame()
    game.deleteAllTip()

    game.placeBlackTip(0, 0)
    game.placeWhiteTip(1, 0)
    game.placeWhiteTip(2, 0)
    game.placeWhiteTip(3, 0)
    game.placeWhiteTip(4, 0)
    game.placeWhiteTip(5, 0)
    game.placeWhiteTip(6, 0)
    assert game.canPlaceTip(7, 0)
    game.placeBlackTip(7, 0)

    assert game.board[0][0].color == Color.Black
    assert game.board[1][0].color == Color.Black
    assert game.board[2][0].color == Color.Black
    assert game.board[3][0].color == Color.Black
    assert game.board[4][0].color == Color.Black
    assert game.board[5][0].color == Color.Black
    assert game.board[6][0].color == Color.Black
    assert game.board[7][0].color == Color.Black

    # outline: should update max range of lower 
    # expected: update tips to black color
    game = newGame()
    game.deleteAllTip()

    game.placeBlackTip(7, 0)
    game.placeWhiteTip(6, 0)
    game.placeWhiteTip(5, 0)
    game.placeWhiteTip(4, 0)
    game.placeWhiteTip(3, 0)
    game.placeWhiteTip(2, 0)
    game.placeWhiteTip(1, 0)
    assert game.canPlaceTip(0, 0)
    game.placeBlackTip(0, 0)

    assert game.board[0][0].color == Color.Black
    assert game.board[1][0].color == Color.Black
    assert game.board[2][0].color == Color.Black
    assert game.board[3][0].color == Color.Black
    assert game.board[4][0].color == Color.Black
    assert game.board[5][0].color == Color.Black
    assert game.board[6][0].color == Color.Black
    assert game.board[7][0].color == Color.Black

    # outline: should update max range of left 
    # expected: update tips to black color
    game = newGame()
    game.deleteAllTip()

    game.placeBlackTip(0, 0)
    game.placeWhiteTip(0, 1)
    game.placeWhiteTip(0, 2)
    game.placeWhiteTip(0, 3)
    game.placeWhiteTip(0, 4)
    game.placeWhiteTip(0, 5)
    game.placeWhiteTip(0, 6)
    assert game.canPlaceTip(0, 7)
    game.placeBlackTip(0, 7)

    assert game.board[0][0].color == Color.Black
    assert game.board[0][1].color == Color.Black
    assert game.board[0][2].color == Color.Black
    assert game.board[0][3].color == Color.Black
    assert game.board[0][4].color == Color.Black
    assert game.board[0][5].color == Color.Black
    assert game.board[0][6].color == Color.Black
    assert game.board[0][7].color == Color.Black

    # outline: should update max range of right 
    # expected: update tips to black color
    game = newGame()
    game.deleteAllTip()

    game.placeBlackTip(0, 7)
    game.placeWhiteTip(0, 6)
    game.placeWhiteTip(0, 5)
    game.placeWhiteTip(0, 4)
    game.placeWhiteTip(0, 3)
    game.placeWhiteTip(0, 2)
    game.placeWhiteTip(0, 1)
    assert game.canPlaceTip(0, 0)
    game.placeBlackTip(0, 0)

    assert game.board[0][7].color == Color.Black
    assert game.board[0][6].color == Color.Black
    assert game.board[0][5].color == Color.Black
    assert game.board[0][4].color == Color.Black
    assert game.board[0][3].color == Color.Black
    assert game.board[0][2].color == Color.Black
    assert game.board[0][1].color == Color.Black
    assert game.board[0][0].color == Color.Black

    # outline: should update max range of update upper right
    # expected: update tips to black color
    game = newGame()
    game.deleteAllTip()

    game.placeBlackTip(0, 7)
    game.placeWhiteTip(1, 6)
    game.placeWhiteTip(2, 5)
    game.placeWhiteTip(3, 4)
    game.placeWhiteTip(4, 3)
    game.placeWhiteTip(5, 2)
    game.placeWhiteTip(6, 1)
    assert game.canPlaceTip(7, 0)
    game.placeBlackTip(7, 0)

    assert game.board[0][7].color == Color.Black
    assert game.board[1][6].color == Color.Black
    assert game.board[2][5].color == Color.Black
    assert game.board[3][4].color == Color.Black
    assert game.board[4][3].color == Color.Black
    assert game.board[5][2].color == Color.Black
    assert game.board[6][1].color == Color.Black
    assert game.board[7][0].color == Color.Black

    # outline: should update max range of update upper left
    # expected: update tips to black color
    game = newGame()
    game.deleteAllTip()

    game.placeBlackTip(7, 7)
    game.placeWhiteTip(6, 6)
    game.placeWhiteTip(5, 5)
    game.placeWhiteTip(4, 4)
    game.placeWhiteTip(3, 3)
    game.placeWhiteTip(2, 2)
    game.placeWhiteTip(1, 1)
    assert game.canPlaceTip(0, 0)
    game.placeBlackTip(0, 0)

    assert game.board[7][7].color == Color.Black
    assert game.board[6][6].color == Color.Black
    assert game.board[5][5].color == Color.Black
    assert game.board[4][4].color == Color.Black
    assert game.board[3][3].color == Color.Black
    assert game.board[2][2].color == Color.Black
    assert game.board[1][1].color == Color.Black
    assert game.board[0][0].color == Color.Black

    # outline: should update max range of update lower right
    # expected: update tips to black color
    game = newGame()
    game.deleteAllTip()

    game.placeBlackTip(0, 0)
    game.placeWhiteTip(1, 1)
    game.placeWhiteTip(2, 2)
    game.placeWhiteTip(3, 3)
    game.placeWhiteTip(4, 4)
    game.placeWhiteTip(5, 5)
    game.placeWhiteTip(6, 6)
    assert game.canPlaceTip(7, 7)
    game.placeBlackTip(7, 7)

    assert game.board[0][0].color == Color.Black
    assert game.board[1][1].color == Color.Black
    assert game.board[2][2].color == Color.Black
    assert game.board[3][3].color == Color.Black
    assert game.board[4][4].color == Color.Black
    assert game.board[5][5].color == Color.Black
    assert game.board[6][6].color == Color.Black
    assert game.board[7][7].color == Color.Black

    # outline: should update max range of update lower left
    # expected: update tips to black color
    game = newGame()
    game.deleteAllTip()

    game.placeBlackTip(7, 0)
    game.placeWhiteTip(6, 1)
    game.placeWhiteTip(5, 2)
    game.placeWhiteTip(4, 3)
    game.placeWhiteTip(3, 4)
    game.placeWhiteTip(2, 5)
    game.placeWhiteTip(1, 6)
    assert game.canPlaceTip(0, 7)
    game.placeBlackTip(0, 7)

    assert game.board[7][0].color == Color.Black
    assert game.board[6][1].color == Color.Black
    assert game.board[5][2].color == Color.Black
    assert game.board[4][3].color == Color.Black
    assert game.board[3][4].color == Color.Black
    assert game.board[2][5].color == Color.Black
    assert game.board[1][6].color == Color.Black
    assert game.board[0][7].color == Color.Black

  block test_skip:
    var game = newGame()
    game.deleteAllTip()

    # all white tip
    game.placeWhiteTip(7, 0)
    game.placeWhiteTip(6, 1)
    game.placeWhiteTip(5, 2)
    game.placeWhiteTip(4, 3)
    game.placeWhiteTip(3, 4)
    game.placeWhiteTip(2, 5)
    game.placeWhiteTip(1, 6)
    game.placeWhiteTip(0, 7)

    assert game.shouldSkip
