module test_perfect_player
  contains
    subroutine test_empty_game
      use fruit
      use perfect_player

      implicit none
      integer, dimension (3,3) :: given_board
      integer, dimension (1,2) :: expected_moves
      integer, dimension (:,:), allocatable :: actual_moves

      given_board = reshape( &
        (/0, 0, 0,           &
          0, 0, 0,           &
          0, 0, 0/),         &
        (/3, 3/)             &
      )

      expected_moves = reshape(        &
        (/1, 1, 1, 2, 2, 2, 3, 3, 3,   &
          1, 2, 3, 1, 2, 3, 1, 2, 3/), &
        (/1, 2/)                       &
      )

      actual_moves = best_moves(given_board, 1)

      call assert_equals(expected_moves, actual_moves, 1, 2, "Finds the first move")
    end subroutine test_empty_game

    subroutine test_one_move_for_win_available
      use fruit
      use perfect_player

      implicit none
      integer, dimension (3,3) :: given_board
      integer, dimension (1,2) :: expected_moves
      integer, dimension (:,:), allocatable :: actual_moves

      given_board = reshape( &
        (/1, 1, 2,           &
          1, 2, 2,           &
          0, 2, 1/),         &
        (/3, 3/)             &
      )

      expected_moves = reshape((/1, 3/), (/1, 2/))

      actual_moves = best_moves(given_board, 1)

      call assert_equals(expected_moves, actual_moves, 1, 2, "Finds the winning move")
    end subroutine test_one_move_for_win_available

    subroutine test_different_move_for_win_available
      use fruit
      use perfect_player

      implicit none
      integer, dimension (3,3) :: given_board
      integer, dimension (1,2) :: expected_moves
      integer, dimension (:,:), allocatable :: actual_moves

      given_board = reshape( &
        (/2, 1, 1,           &
          2, 0, 1,           &
          1, 2, 2/),         &
        (/3, 3/)             &
      )

      expected_moves = reshape((/2, 2/), (/1, 2/))

      actual_moves = best_moves(given_board, 2)

      call assert_equals(expected_moves, actual_moves, 1, 2, "Finds the other winning move")
    end subroutine test_different_move_for_win_available

    subroutine test_unwinnable_game
      use fruit
      use perfect_player

      implicit none
      integer, dimension (3,3) :: given_board
      integer, dimension (1,2) :: expected_moves
      integer, dimension (:,:), allocatable :: actual_moves

      given_board = reshape( &
        (/0, 2, 0,           &
          0, 0, 2,           &
          1, 1, 2/),         &
        (/3, 3/)             &
      )

      expected_moves = reshape( &
        (/1, 1, 2, 3,           &
          1, 2, 2, 1/),         &
        (/1, 2/)                &
      )

      actual_moves = best_moves(given_board, 1)

      call assert_equals(expected_moves, actual_moves, 1, 2, "Finds the defensive move")
    end subroutine test_unwinnable_game
end module test_perfect_player
