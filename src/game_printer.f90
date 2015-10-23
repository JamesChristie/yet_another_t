! NOTE (JamesChristie) While the rest of the code bases the bounding
! of any integer array used to represent a board with the BOARD_SIZE
! constant in the board module, this file assumes dimensions of 3x3.
! It is possible, of course, to continue that abstraction up to this
! level of the application, but there is not universe in which Fortran
! would make that decision worthwhile at this stage.
module game_printer
  implicit none

  integer :: OUTPUT_LENGTH = 79

  character, private, parameter :: BORDER       = '#'
  character, private, parameter :: VERTICAL     = '|'
  character, private, parameter :: HORIZONTAL   = '-'
  character, private, parameter :: INTERSECTION = '+'
  character, private, parameter :: EMPTY        = ' '
  character, private, parameter :: PLAYER1      = 'X'
  character, private, parameter :: PLAYER2      = 'O'
  character, private, parameter :: ERROR        = 'E'

  character (len=9), parameter :: TOP_LEGEND = EMPTY//EMPTY//EMPTY//'1'//&
                                               EMPTY//'2'//EMPTY//'3'//EMPTY

  character (len=9), parameter :: TOP_BORDER = EMPTY//EMPTY//BORDER//BORDER//&
                                               BORDER//BORDER//BORDER//BORDER//&
                                               BORDER

  character (len=9), parameter :: BOT_BORDER = EMPTY//EMPTY//BORDER//BORDER//&
                                               BORDER//BORDER//BORDER//BORDER//&
                                               BORDER

  character (len=9), parameter :: HOR_DIVIDER = EMPTY//EMPTY//BORDER//HORIZONTAL//&
                                                INTERSECTION//HORIZONTAL//&
                                                INTERSECTION//HORIZONTAL//BORDER

  private row_string, owner_char

  contains
    subroutine print_game(given_board)
      implicit none
      integer, dimension (3,3) :: given_board

      write(*, '(A)') game_string(given_board)
    end subroutine print_game

    function game_string(given_board)
      implicit none
      integer, dimension (3,3) :: given_board
      character (len=OUTPUT_LENGTH) :: game_string

      game_string = TOP_LEGEND//                      &
                    new_line('A')//                   &
                    TOP_BORDER//                      &
                    new_line('A')//                   &
                    row_string(1, '1', given_board)// &
                    new_line('A')//                   &
                    HOR_DIVIDER//                     &
                    new_line('A')//                   &
                    row_string(2, '2', given_board)// &
                    new_line('A')//                   &
                    HOR_DIVIDER//                     &
                    new_line('A')//                   &
                    row_string(3, '3', given_board)// &
                    new_line('A')//                   &
                    BOT_BORDER
    end function game_string

    ! NOTE (JamesChristie) Fortran has no built-in method for
    ! casting integers to strings or performing interpolation,
    ! hence the double arg of slightly varied types.
    function row_string(row_number, row_title, given_board)
      implicit none
      integer :: row_number
      character :: row_title, left, middle, right
      integer, dimension (3,3) :: given_board
      character (len=9) :: row_string

      left   = owner_char(given_board(1, row_number))
      middle = owner_char(given_board(2, row_number))
      right  = owner_char(given_board(3, row_number))

      row_string = row_title//EMPTY//BORDER// &
                   left//VERTICAL//middle//   &
                   VERTICAL//right//BORDER
    end function row_string

    function owner_char(player)
      implicit none
      integer :: player
      character :: owner_char

      if (player == 0) then
        owner_char = EMPTY
      else if (player == 1) then
        owner_char = PLAYER1
      else if (player == 2) then
        owner_char = PLAYER2
      else
        owner_char = ERROR
      end if
    end function owner_char
end module game_printer
