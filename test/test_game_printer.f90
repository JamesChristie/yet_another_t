module test_game_printer
  contains
    subroutine test_game_string
      use fruit
      use game_printer

      implicit none
      integer, dimension (3,3) :: given_board
      character (len=OUTPUT_LENGTH) :: expected_string
      character (len=OUTPUT_LENGTH) :: actual_string

      given_board = reshape( &
        (/1, 2, 0,           &
          0, 2, 2,           &
          1, 1, 0/),         &
        (/3, 3/)             &
      )

      expected_string = '   1 2 3 '//new_line('A')//&
                        '  #######'//new_line('A')//&
                        '1 #X|O| #'//new_line('A')//&
                        '  #-+-+-#'//new_line('A')//&
                        '2 # |O|O#'//new_line('A')//&
                        '  #-+-+-#'//new_line('A')//&
                        '3 #X|X| #'//new_line('A')//&
                        '  #######'

      actual_string = game_string(given_board)

      call assert_equals(expected_string, actual_string, "Creates the string")
    end subroutine test_game_string
end module test_game_printer
