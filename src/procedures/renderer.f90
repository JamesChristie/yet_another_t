module renderer
  use board, only: BOARD_SIZE
  use game_printer

  implicit none

  contains
    subroutine render(given_board, human_move)
      implicit none
      integer, dimension (BOARD_SIZE,BOARD_SIZE) :: given_board
      logical :: human_move
      character (len=20) :: move_message

      if (human_move) then
        move_message = "Player move"
      else
        move_message = "Computer move"
      end if

      print *, new_line('A')//move_message//new_line('A')

      call print_game(given_board)
    end subroutine render
end module renderer
