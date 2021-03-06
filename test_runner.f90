! NOTE (JamesChristie) The Fruit test suite lacks test discovery
! so all specs must be invoked explicitly. It does have the
! ability to compartmentalize tests into sub-suites or "baskets,"
! but the library has a severe lack of documentation and it seemed
! very not worth the time.
program fruit_test_driver
  use fruit
  use test_integer_lists
  use test_coordinate_lists
  use test_board
  use test_detection
  use test_game_printer
  use test_perfect_player
  use test_computer_interaction
  use test_reporting

  call init_fruit

  ! Integer lists util
  call test_appending_to_empty_list
  call test_appending_to_populated_list

  ! Coordinate lists util
  call test_append_to_emtpy_coord_list
  call test_append_to_populated_coord_list

  ! Board tests
  call test_new_board
  call test_move_is_valid
  call test_move_is_valid_with_invalid_move
  call test_move_is_valid_with_out_of_bounds_move
  call test_valid_moves
  call test_apply_move_with_empty_game
  call test_apply_move_with_ongoing_game
  call test_apply_move_illegal_move

  ! Detection tests
  call test_game_is_over
  call test_tied_game_is_not_loss
  call test_lost_game_is_loss
  call test_top_row_win
  call test_middle_row_win
  call test_bottom_row_win
  call test_left_column_win
  call test_middle_column_win
  call test_right_column_win
  call test_left_diagonal_win
  call test_right_diagonal_win
  call test_tied_game
  call test_game_in_progress

  ! Game printer tests
  call test_game_string

  ! Perfect player tests
  call test_empty_game
  call test_one_move_for_win_available
  call test_different_move_for_win_available
  call test_unwinnable_game
  call test_one_move_for_tie_available
  call test_defense_against_win

  ! Computer player tests
  call test_get_next_move

  ! Reporting tests
  call test_won_game_message
  call test_lost_game_message
  call test_tied_game_message

  call fruit_summary
end program fruit_test_driver
