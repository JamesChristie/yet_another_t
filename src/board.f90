module board
  implicit none
  integer, parameter :: BOARD_SIZE = 3
  integer, private :: EMPTY_VALUE = 0

  contains
    function new_board()
      implicit none
      integer, dimension (BOARD_SIZE,BOARD_SIZE) :: new_board

      new_board = EMPTY_VALUE
    end function new_board

    function valid_moves(given_board)
      use coordinate_lists, only: append_to_coordinate_list

      implicit none
      integer :: x, y
      integer, dimension (BOARD_SIZE,BOARD_SIZE) :: given_board
      integer, dimension (:,:), allocatable :: valid_moves

      allocate(valid_moves(0, 2))

      do x=1, BOARD_SIZE
        do y=1, BOARD_SIZE
          if (given_board(x, y) == EMPTY_VALUE) then
            call append_to_coordinate_list(valid_moves, x, y)
          endif
        end do
      end do
    end function valid_moves

    function apply_move(given_board, player, x, y)
      implicit none
      integer :: x, y, player
      integer, dimension (BOARD_SIZE,BOARD_SIZE) :: given_board 
      integer, dimension (BOARD_SIZE,BOARD_SIZE) :: new_board 
      integer, dimension (BOARD_SIZE,BOARD_SIZE) :: apply_move

      if (given_board(x, y) == EMPTY_VALUE) then
        new_board = given_board
        new_board(x, y) = player

        apply_move = new_board
      else
        apply_move = given_board
      endif
    end function apply_move
end module board
