module test_perfect_player
  contains
    subroutine test_empty_game
      use fruit
      use perfect_player

      implicit none
      integer, dimension (3,3) :: given_board
      integer, dimension (9,2) :: expected_moves
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
        (/9, 2/)                       &
      )

      actual_moves = best_moves(given_board, 1)

      call assert_equals(expected_moves, actual_moves, 9, 2, "Finds the first move")
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
      integer, dimension (4,2) :: expected_moves
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
        (/4, 2/)                &
      )

      actual_moves = best_moves(given_board, 1)

      call assert_equals(expected_moves, actual_moves, 4, 2, "Finds the pointless moves")
    end subroutine test_unwinnable_game

    subroutine test_one_move_for_tie_available
      use fruit
      use perfect_player

      implicit none
      integer, dimension (3,3) :: given_board
      integer, dimension (1,2) :: expected_moves
      integer, dimension (:,:), allocatable :: actual_moves

      given_board = reshape( &
        (/1, 2, 1,           &
          2, 2, 1,           &
          0, 1, 2/),         &
        (/3, 3/)             &
      )

      expected_moves = reshape((/1, 3/), (/1, 2/))

      actual_moves = best_moves(given_board, 2)

      call assert_equals(expected_moves, actual_moves, 1, 2, "Finds the tying move")
    end subroutine

    ! *********************************************
    !  Column:            1
    !  Row:               2
    !  Score:            -10
    ! 
    !  Column:            1
    !  Row:               3
    !  Score:            -10
    ! 
    !  Column:            2
    !  Row:               1
    !  Score:            -10 (should be at least 0)
    ! 
    !  Column:            3
    !  Row:               1
    !  Score:            -10
    ! 
    !  Column:            3
    !  Row:               2
    !  Score:            -10
    ! 
    !  Column:            3
    !  Row:               3
    !  Score:            -10
    ! 
    !    1 2 3 
    !   #######
    ! 1 #O| | #
    !   #-+-+-#
    ! 2 # |X| #
    !   #-+-+-#
    ! 3 # |X| #
    !   #######
    subroutine test_defense_against_win
      use fruit
      use perfect_player

      implicit none
      integer, dimension (3,3) :: given_board
      integer, dimension (1,2) :: expected_moves
      integer, dimension (:,:), allocatable :: actual_moves

      given_board = reshape( &
        (/2, 0, 0,           &
          0, 1, 0,           &
          0, 1, 0/),         &
        (/3, 3/)             &
      )

      expected_moves = reshape( &
        (/2, 1/),               &
        (/1, 2/)                &
      )

      actual_moves = best_moves(given_board, 2)

      call assert_equals(expected_moves, actual_moves, 1, 2, "Finds the defensive move")
    end subroutine test_defense_against_win
end module test_perfect_player
