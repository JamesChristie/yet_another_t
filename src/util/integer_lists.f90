module integer_lists
  contains
    subroutine append_to_integer_list(given_integers, new_integer)
      implicit none
      integer :: i, new_integer, move_size, new_size
      integer, allocatable :: given_integers(:)
      integer, allocatable :: temp_integers(:)

      move_size = size(given_integers)
      new_size  = move_size + 1

      allocate(temp_integers(move_size))

      do i=1, move_size
        temp_integers(i) = given_integers(i)
      end do

      deallocate(given_integers)
      allocate(given_integers(new_size))

      do i=1, move_size
        given_integers(i) = temp_integers(i)
      end do

      deallocate(temp_integers)

      given_integers(new_size) = new_integer
    end subroutine append_to_integer_list
end module integer_lists
