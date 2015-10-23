module test_detection
  contains
    subroutine test_game_is_over
      use fruit
      use detection

      implicit none
      integer, dimension (3,3) :: given_board
      logical :: win_status

      given_board = reshape( &
        (/1, 1, 1,           &
          0, 0, 0,           &
          0, 0, 0/),         &
        (/3, 3/)             &
      )

      win_status = game_is_over(given_board)

      call assert_true(win_status, "Won game is over")
    end subroutine test_game_is_over

    subroutine test_tied_game_is_not_loss
      use fruit
      use detection

      implicit none
      integer, dimension (3,3) :: given_board
      logical :: loss_status, tie_status

      given_board = reshape( &
        (/2, 1, 2,           &
          1, 1, 2,           &
          2, 2, 1/),         &
        (/3, 3/)             &
      )

      loss_status = game_lost_for(given_board, 1) .or. &
                    game_lost_for(given_board, 2)

      tie_status  = game_is_tie(given_board)

      call assert_false(loss_status, "It is not a loss")
      call assert_true(tie_status, "It is a tie")
    end subroutine test_tied_game_is_not_loss

    subroutine test_lost_game_is_loss
      use fruit
      use detection

      implicit none
      integer, dimension (3,3) :: given_board
      logical :: loss_status, tie_status

      given_board = reshape( &
        (/1, 0, 2,           &
          2, 1, 0,           &
          0, 0, 1/),         &
        (/3, 3/)             &
      )

      loss_status = game_lost_for(given_board, 2)

      tie_status  = game_is_tie(given_board)

      call assert_true(loss_status, "It is a loss")
      call assert_false(tie_status, "It is not a tie")
    end subroutine test_lost_game_is_loss

    subroutine test_top_row_win
      use fruit
      use detection

      implicit none
      integer, dimension (3,3) :: given_board
      logical :: win_status

      given_board = reshape( &
        (/1, 1, 1,           &
          0, 0, 0,           &
          0, 0, 0/),         &
        (/3, 3/)             &
      )

      win_status = game_won_for(given_board, 1)

      call assert_true(win_status, "Reports top row win")
    end subroutine test_top_row_win

    subroutine test_middle_row_win
      use fruit
      use detection

      implicit none
      integer, dimension (3,3) :: given_board
      logical :: win_status

      given_board = reshape( &
        (/0, 0, 0,           &
          1, 1, 1,           &
          0, 0, 0/),         &
        (/3, 3/)             &
      )

      win_status = game_won_for(given_board, 1)

      call assert_true(win_status, "Reports middle row win")
    end subroutine test_middle_row_win

    subroutine test_bottom_row_win
      use fruit
      use detection

      implicit none
      integer, dimension (3,3) :: given_board
      logical :: win_status

      given_board = reshape( &
        (/0, 0, 0,           &
          0, 0, 0,           &
          1, 1, 1/),         &
        (/3, 3/)             &
      )

      win_status = game_won_for(given_board, 1)

      call assert_true(win_status, "Reports bottom row win")
    end subroutine test_bottom_row_win

    subroutine test_left_column_win
      use fruit
      use detection

      implicit none
      integer, dimension (3,3) :: given_board
      logical :: win_status

      given_board = reshape( &
        (/1, 0, 0,           &
          1, 0, 0,           &
          1, 0, 0/),         &
        (/3, 3/)             &
      )

      win_status = game_won_for(given_board, 1)

      call assert_true(win_status, "Reports left column win")
    end subroutine test_left_column_win

    subroutine test_middle_column_win
      use fruit
      use detection

      implicit none
      integer, dimension (3,3) :: given_board
      logical :: win_status

      given_board = reshape( &
        (/0, 1, 0,           &
          0, 1, 0,           &
          0, 1, 0/),         &
        (/3, 3/)             &
      )

      win_status = game_won_for(given_board, 1)

      call assert_true(win_status, "Reports middle column win")
    end subroutine test_middle_column_win

    subroutine test_right_column_win
      use fruit
      use detection

      implicit none
      integer, dimension (3,3) :: given_board
      logical :: win_status

      given_board = reshape( &
        (/0, 0, 2,           &
          0, 0, 2,           &
          0, 0, 2/),         &
        (/3, 3/)             &
      )

      win_status = game_won_for(given_board, 2)

      call assert_true(win_status, "Reports right column win")
    end subroutine test_right_column_win

    subroutine test_left_diagonal_win
      use fruit
      use detection

      implicit none
      integer, dimension (3,3) :: given_board
      logical :: win_status

      given_board = reshape( &
        (/2, 0, 0,           &
          0, 2, 0,           &
          0, 0, 2/),         &
        (/3, 3/)             &
      )

      win_status = game_won_for(given_board, 2)

      call assert_true(win_status, "Reports left diagonal win")
    end subroutine test_left_diagonal_win

    subroutine test_right_diagonal_win
      use fruit
      use detection

      implicit none
      integer, dimension (3,3) :: given_board
      logical :: win_status

      given_board = reshape( &
        (/0, 0, 2,           &
          0, 2, 0,           &
          2, 0, 0/),         &
        (/3, 3/)             &
      )

      win_status = game_won_for(given_board, 2)

      call assert_true(win_status, "Reports right diagonal win")
    end subroutine test_right_diagonal_win

    subroutine test_tied_game
      use fruit
      use detection

      implicit none
      integer, dimension (3,3) :: given_board
      logical :: tie_status

      given_board = reshape( &
        (/1, 2, 2,           &
          2, 1, 1,           &
          2, 1, 2/),         &
        (/3, 3/)             &
      )

      tie_status = game_is_tie(given_board)

      call assert_true(tie_status, "Reports tie")
    end subroutine test_tied_game

    subroutine test_game_in_progress
      use fruit
      use detection

      implicit none
      integer, dimension (3,3) :: given_board
      logical :: win_status, loss_status, tie_status

      given_board = reshape( &
        (/0, 0, 1,           &
          0, 1, 0,           &
          2, 0, 0/),         &
        (/3, 3/)             &
      )

      win_status = game_won_for(given_board, 2)
      loss_status = game_lost_for(given_board, 2)
      tie_status = game_is_tie(given_board)

      call assert_false(win_status, "Game isn't won")
      call assert_false(loss_status, "Game isn't lost")
      call assert_false(tie_status, "Game isn't tied")
    end subroutine test_game_in_progress
end module test_detection
