module human_interaction
  implicit none

  type human_player
    integer :: player_id
    character (len=20) :: player_name

    contains
      procedure :: get_next_move
  end type human_player

  contains
    function get_next_move(this, given_board)
      use board
      use user_input, only: read_move

      implicit none
      class(human_player) :: this
      integer, dimension (BOARD_SIZE,BOARD_SIZE) :: given_board
      integer, dimension(2) :: get_next_move

      do while (.true.)
        get_next_move = read_move()
        if (move_is_valid(given_board, get_next_move(1), get_next_move(2))) exit
        write(*,'(A)') new_line('A')//"Invalid move entered"
      enddo
    end function get_next_move
end module human_interaction
