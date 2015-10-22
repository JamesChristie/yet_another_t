module board
  implicit none
  integer :: BOARD_SIZE = 3
  integer, private :: EMPTY_VALUE = 0

  private append_to_moves

  contains
    function new_board()
      implicit none
      integer, dimension (BOARD_SIZE,BOARD_SIZE) :: new_board

      new_board = EMPTY_VALUE
    end function new_board

    function valid_moves(given_board)
      implicit none
      integer :: x, y
      integer, dimension (BOARD_SIZE,BOARD_SIZE) :: given_board
      integer, dimension (:,:), allocatable :: valid_moves

      allocate(valid_moves(0, 2))

      do x=1, BOARD_SIZE
        do y=1, BOARD_SIZE
          if (given_board(x, y) == EMPTY_VALUE) then
            call append_to_moves(valid_moves, x, y)
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

    subroutine append_to_moves(valid_moves, x, y)
      implicit none
      integer :: i, x, y, move_size, new_size
      integer, dimension (:,:), allocatable :: valid_moves
      integer, dimension (:,:), allocatable :: temp_moves

      move_size = size(valid_moves, 1)
      new_size  = move_size + 1

      allocate(temp_moves(move_size, 2))

      do i=1, move_size
        temp_moves(i, 1) = valid_moves(i, 1)
        temp_moves(i, 2) = valid_moves(i, 2)
      end do

      deallocate(valid_moves)
      allocate(valid_moves(new_size, 2))

      do i=1, move_size
        valid_moves(i, 1) = temp_moves(i, 1)
        valid_moves(i, 2) = temp_moves(i, 2)
      end do

      deallocate(temp_moves)

      valid_moves(new_size, 1) = x
      valid_moves(new_size, 2) = y
    end subroutine append_to_moves
end module board
