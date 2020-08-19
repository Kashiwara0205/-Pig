import ./tip
import ./main

block test:
  block should_make_new_game:
    let game = newGame()
    assert game.board[3][3].color == Color.White
    assert game.board[3][4].color == Color.Black
    assert game.board[4][3].color == Color.Black
    assert game.board[4][4].color == Color.White
  block should_reverse_uppder:
    let game = newGame()
    game.placeBlackTip(5, 4)
    assert game.board[4][3].color == Color.Black
    assert game.board[4][4].color == Color.Black
    assert game.board[5][4].color == Color.Black
  block should_reverse_right:
    let game = newGame()
    game.placeBlackTip(2, 3)
    assert game.board[2][3].color == Color.Black
    assert game.board[3][3].color == Color.Black
    assert game.board[4][3].color == Color.Black
  block should_reverse_left:
    let game = newGame()
    game.placeBlackTip(4, 5)
    assert game.board[4][3].color == Color.Black
    assert game.board[4][4].color == Color.Black
    assert game.board[4][5].color == Color.Black
  block should_reverse_lower:
    let game = newGame()
    game.placeBlackTip(2, 3)
    assert game.board[2][3].color == Color.Black
    assert game.board[3][3].color == Color.Black
    assert game.board[4][3].color == Color.Black
  block should_reverse_upper_right:
    let game = newGame()
    game.placeWhiteTip(5, 3)
    assert game.board[4][3].color == Color.White
    game.placeBlackTip(5, 2)
    assert game.board[5][2].color == Color.Black
    assert game.board[4][3].color == Color.Black
    assert game.board[3][4].color == Color.Black
  block should_reverse_lower_right:
    let game = newGame()
    game.placeBlackTip(2, 3)
    assert game.board[3][3].color == Color.Black
    game.placeWhiteTip(2, 2)
    assert game.board[2][2].color == Color.White
    assert game.board[3][3].color == Color.White
    assert game.board[4][4].color == Color.White