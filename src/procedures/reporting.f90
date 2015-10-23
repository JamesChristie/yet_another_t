module reporting
  use board, only: BOARD_SIZE
  use detection
  use human_interaction
  use computer_interaction

  implicit none

  contains
    subroutine report_end_state(given_board, human, computer)
      implicit none
      type(human_player) :: human
      type(computer_player) :: computer
      integer, dimension (BOARD_SIZE,BOARD_SIZE) :: given_board
      character (len=30) :: message

      message = ending_message( &
        given_board,            &
        human%player_id,        &
        computer%player_id      &
      )

      print *, new_line('A')//message//new_line('A')
    end subroutine report_end_state

    function ending_message(given_board, human_id, computer_id)
      implicit none
      integer :: human_id, computer_id
      integer, dimension (BOARD_SIZE,BOARD_SIZE) :: given_board
      logical :: human_win, computer_win
      character (len=30) :: ending_message

      human_win    = game_won_for(given_board, human_id)
      computer_win = game_won_for(given_board, computer_id)

      if (human_win) then
        ending_message = " ** Player has won **"
      else if (computer_win) then
        ending_message = " ** Computer has won **"
      else
        ending_message = " ** Nobody has won **"
      end if
    end function ending_message
end module reporting
