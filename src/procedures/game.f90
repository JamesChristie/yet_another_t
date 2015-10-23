module game
  use board
  use detection
  use human_interaction
  use computer_interaction

  implicit none

  contains
    subroutine update_game(given_board, human, computer, current_player_id)
      implicit none
      integer :: current_player_id
      type(human_player) :: human
      type(computer_player) :: computer
      integer, dimension (BOARD_SIZE,BOARD_SIZE) :: given_board
      integer, dimension (2) :: move

      if (current_player_id == human%player_id) then
        move = get_human_move(given_board)
      else
        move = computer%get_next_move(given_board)
      end if

      given_board       = apply_move(given_board, current_player_id, move(1), move(2))
      current_player_id = get_opponent(current_player_id)
    end subroutine update_game
end module game
