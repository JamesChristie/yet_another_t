module human_interaction
  implicit none

  type human_player
    integer :: player_id
    character (len=20) :: player_name
  end type human_player

  contains
    function get_human_move(given_board)
      use board
      use user_input, only: read_move

      implicit none
      integer, dimension (BOARD_SIZE,BOARD_SIZE) :: given_board
      logical :: valid_move
      integer, dimension(2) :: get_human_move

      do while (.true.)
        get_human_move = read_move()

        valid_move = move_is_valid( &
          given_board,              &
          get_human_move(1),        &
          get_human_move(2)         &
        )

        if (valid_move) then
          exit
        else
          print *, new_line('A')//"Invalid move entered"//new_line('A')
        end if
      enddo
    end function get_human_move
end module human_interaction
