module test_computer_interaction
  contains
    subroutine test_get_next_move
      use fruit
      use board, only: BOARD_SIZE
      use computer_interaction

      implicit none
      type(computer_player) :: player
      integer, dimension (BOARD_SIZE,BOARD_SIZE) :: given_board
      integer, dimension (2) :: expected_move, actual_move

      player = computer_player(player_id=1)

      given_board = reshape( &
        (/1, 1, 2,           &
          1, 2, 2,           &
          0, 2, 1/),         &
        (/3, 3/)             &
      )

      expected_move = (/1, 3/)

      actual_move = player%get_next_move(given_board)

      call assert_equals(expected_move, actual_move, 2, "Makes a move")
    end subroutine test_get_next_move
end module test_computer_interaction
