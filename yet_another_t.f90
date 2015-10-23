program yet_another_t
  use board
  use detection
  use human_interaction
  use computer_interaction
  use renderer
  use game
  use reporting

  implicit none
  integer :: current_player_id = 1
  type(human_player) :: human
  type(computer_player) :: computer
  integer, dimension (BOARD_SIZE,BOARD_SIZE) :: current_board

  human         = human_player(player_id=1, player_name="Player")
  computer      = computer_player(player_id=2, player_name="Computer")
  current_board = new_board()

  call render(current_board, .false.)

  do while (.true.)
    call update_game(current_board, human, computer, current_player_id)

    call render(current_board, current_player_id == human%player_id)

    if (game_is_over(current_board)) then
      call report_end_state(current_board, human, computer)
      exit
    end if
  enddo
end program yet_another_t
