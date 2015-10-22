module test_detection
  contains
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

      call assert_true(win_status)
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

      call assert_true(win_status)
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

      call assert_true(win_status)
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

      call assert_true(win_status)
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

      call assert_true(win_status)
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

      call assert_true(win_status)
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

      call assert_true(win_status)
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

      call assert_true(win_status)
    end subroutine test_right_diagonal_win
end module test_detection
