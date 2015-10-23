module coordinate_lists
  contains
    ! NOTE (JamesChristie) A small style note: even local vars
    ! must be defined at the top of a procedure (function or
    ! subroutine) like arguments and return values.
    subroutine append_to_coordinate_list(given_cordinates, x, y)
      implicit none
      integer :: i, x, y, move_size, new_size
      integer, dimension (:,:), allocatable :: given_cordinates
      integer, dimension (:,:), allocatable :: temp_coordinates

      move_size = size(given_cordinates, 1)
      new_size  = move_size + 1

      allocate(temp_coordinates(move_size, 2))

      do i=1, move_size
        temp_coordinates(i, 1) = given_cordinates(i, 1)
        temp_coordinates(i, 2) = given_cordinates(i, 2)
      end do

      deallocate(given_cordinates)
      allocate(given_cordinates(new_size, 2))

      do i=1, move_size
        given_cordinates(i, 1) = temp_coordinates(i, 1)
        given_cordinates(i, 2) = temp_coordinates(i, 2)
      end do

      deallocate(temp_coordinates)

      given_cordinates(new_size, 1) = x
      given_cordinates(new_size, 2) = y
    end subroutine append_to_coordinate_list
end module coordinate_lists
