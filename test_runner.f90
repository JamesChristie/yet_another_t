program fruit_test_driver
  use fruit
  use test_board
  use test_detection
  use test_game_printer

  call init_fruit

  ! Board tests
  call test_new_board
  call test_valid_moves
  call test_apply_move_with_empty_game
  call test_apply_move_with_ongoing_game
  call test_apply_move_illegal_move

  ! Detection tests
  call test_top_row_win
  call test_middle_row_win
  call test_bottom_row_win
  call test_left_column_win
  call test_middle_column_win
  call test_right_column_win
  call test_left_diagonal_win
  call test_right_diagonal_win

  ! Game printer tests
  call test_game_string
 
  call fruit_summary
end program fruit_test_driver
