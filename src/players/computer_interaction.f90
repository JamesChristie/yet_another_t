module computer_interaction
  implicit none

  type computer_player
    integer :: player_id
    character (len=20) :: player_name = "Computer"

    contains
      procedure :: get_next_move
  end type computer_player

  contains
    function get_next_move(this, given_board)
      use board,          only: BOARD_SIZE
      use perfect_player, only: best_moves

      implicit none
      class(computer_player) :: this
      integer, dimension (BOARD_SIZE,BOARD_SIZE) :: given_board
      integer, dimension (:,:), allocatable :: move_list
      integer :: get_next_move(2)

      move_list     = best_moves(given_board, this%player_id)
      get_next_move = move_list(1, 1:2)
    end function get_next_move
end module computer_interaction
