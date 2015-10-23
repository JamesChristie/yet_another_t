module user_input
  implicit none

  contains
    function read_move()
      implicit none
      integer :: column, row
      integer, dimension(2) :: read_move

      write(*,'(A)',advance='no') new_line('A')//"Please enter a column number: "
      read(*,'(i10)') column
      write(*,'(A)',advance='no') new_line('A')//"Please enter a row number: "
      read(*,'(i10)') row

      read_move = (/column, row/)
    end function read_move
end module user_input
