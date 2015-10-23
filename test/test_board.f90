module test_board
  contains
    subroutine test_new_board
      use fruit
      use board

      implicit none
      integer, dimension (3,3) :: expected_board
      integer, dimension (3,3) :: actual_board

      expected_board = reshape( &
        (/0, 0, 0,        &
          0, 0, 0,        &
          0, 0, 0/),      &
        (/3, 3/)          &
      )

      actual_board = new_board()

      call assert_equals(expected_board, actual_board, 3, 3, "Creates a new board")
    end subroutine test_new_board

    subroutine test_move_is_valid
      use fruit
      use board

      implicit none
      integer, dimension (3,3) :: given_board
      integer :: x, y

      given_board = reshape( &
        (/1, 2, 0,           &
          0, 0, 2,           &
          1, 1, 0/),         &
        (/3, 3/)             &
      )

      x = 2
      y = 2

      call assert_true(move_is_valid(given_board, x, y))
    end subroutine test_move_is_valid

    subroutine test_move_is_valid_with_invalid_move
      use fruit
      use board

      implicit none
      integer, dimension (3,3) :: given_board
      integer :: x, y

      given_board = reshape( &
        (/1, 2, 0,           &
          0, 2, 2,           &
          1, 1, 0/),         &
        (/3, 3/)             &
      )

      x = 1
      y = 1

      call assert_false(move_is_valid(given_board, x, y))
    end subroutine test_move_is_valid_with_invalid_move

    subroutine test_move_is_valid_with_out_of_bounds_move
      use fruit
      use board

      implicit none
      integer, dimension (3,3) :: given_board
      integer :: x, y

      given_board = reshape( &
        (/1, 2, 0,           &
          0, 2, 2,           &
          1, 1, 0/),         &
        (/3, 3/)             &
      )

      x = 17
      y = -3

      call assert_false(move_is_valid(given_board, x, y))
    end subroutine test_move_is_valid_with_out_of_bounds_move

    subroutine test_valid_moves
      use fruit
      use board

      implicit none
      integer, dimension (3,3) :: given_board
      integer, dimension (3,2) :: expected_moves
      integer, dimension (:,:), allocatable :: actual_moves

      given_board = reshape( &
        (/1, 2, 0,           &
          0, 2, 2,           &
          1, 1, 0/),         &
        (/3, 3/)             &
      )

      expected_moves = reshape( &
        (/1, 3, 3,              &
          2, 1, 3/),            &
        (/3, 2/)                &
      )

      actual_moves = valid_moves(given_board)

      call assert_equals(expected_moves, actual_moves, 3, 2, "Gets valid moves")
    end subroutine test_valid_moves

    subroutine test_apply_move_with_empty_game
      use fruit
      use board

      implicit none
      integer, dimension (3,3) :: given_board
      integer, dimension (3,3) :: expected_board
      integer, dimension (3,3) :: new_given_board

      given_board = reshape( &
        (/0, 0, 0,           &
          0, 0, 0,           &
          0, 0, 0/),         &
        (/3, 3/)             &
      )

      expected_board = reshape( &
        (/1, 0, 0,              &
          0, 0, 0,              &
          0, 0, 0/),            &
        (/3, 3/)                &
      )

      new_given_board = apply_move(given_board, 1, 1, 1)

      call assert_equals(expected_board, new_given_board, 3, 3, "Move is assigned correctly")
    end subroutine test_apply_move_with_empty_game

    subroutine test_apply_move_with_ongoing_game
      use fruit
      use board

      implicit none
      integer, dimension (3,3) :: given_board
      integer, dimension (3,3) :: expected_board
      integer, dimension (3,3) :: new_given_board

      given_board = reshape( &
        (/1, 0, 2,           &
          0, 1, 2,           &
          0, 0, 0/),         &
        (/3, 3/)             &
      )

      expected_board = reshape( &
        (/1, 0, 2,              &
          0, 1, 2,              &
          0, 0, 2/),            &
        (/3, 3/)                &
      )

      new_given_board = apply_move(given_board, 2, 3, 3)

      call assert_equals(expected_board, new_given_board, 3, 3, "Move is assigned correctly")
    end subroutine test_apply_move_with_ongoing_game

    subroutine test_apply_move_illegal_move
      use fruit
      use board

      implicit none
      integer, dimension (3,3) :: given_board
      integer, dimension (3,3) :: expected_board
      integer, dimension (3,3) :: new_given_board

      given_board = reshape( &
        (/0, 0, 0,           &
          0, 1, 0,           &
          0, 0, 0/),         &
        (/3, 3/)             &
      )

      expected_board = reshape( &
        (/0, 0, 0,              &
          0, 1, 0,              &
          0, 0, 0/),            &
        (/3, 3/)                &
      )

      new_given_board = apply_move(given_board, 2, 2, 2)

      call assert_equals(expected_board, new_given_board, 3, 3, "Move is not made")
    end subroutine test_apply_move_illegal_move
end module test_board
