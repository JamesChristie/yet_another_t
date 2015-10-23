module test_reporting
  contains
    subroutine test_won_game_message
      use fruit
      use reporting

      implicit none
      integer :: human_id, computer_id
      integer, dimension (3,3) :: given_board
      character (len=30) :: expected_message, actual_message

      human_id    = 1
      computer_id = 2

      given_board = reshape( &
        (/1, 2, 0,           &
          0, 1, 2,           &
          0, 0, 1/),         &
        (/3, 3/)             &
      )

      expected_message = " ** Player has won **"

      actual_message = ending_message(given_board, human_id, computer_id)

      call assert_equals(expected_message, actual_message, "Reports player won")
    end subroutine test_won_game_message

    subroutine test_lost_game_message
      use fruit
      use reporting

      implicit none
      integer :: human_id, computer_id
      integer, dimension (3,3) :: given_board
      character (len=30) :: expected_message, actual_message

      human_id    = 2
      computer_id = 1

      given_board = reshape( &
        (/1, 2, 0,           &
          0, 1, 2,           &
          0, 0, 1/),         &
        (/3, 3/)             &
      )

      expected_message = " ** Computer has won **"

      actual_message = ending_message(given_board, human_id, computer_id)

      call assert_equals(expected_message, actual_message, "Reports computer won")
    end subroutine test_lost_game_message

    subroutine test_tied_game_message
      use fruit
      use reporting

      implicit none
      integer :: human_id, computer_id
      integer, dimension (3,3) :: given_board
      character (len=30) :: expected_message, actual_message

      human_id    = 1
      computer_id = 2

      given_board = reshape( &
        (/1, 2, 1,           &
          1, 2, 2,           &
          2, 1, 2/),         &
        (/3, 3/)             &
      )

      expected_message = " ** Nobody has won **"

      actual_message = ending_message(given_board, human_id, computer_id)

      call assert_equals(expected_message, actual_message, "Reports nobody won")
    end subroutine test_tied_game_message
end module test_reporting
