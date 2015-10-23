module user_input
  implicit none

  contains
    ! NOTE (JamesChristie) This function is a volatile failure point
    ! in this application. Fortran has no ability to handle runtime
    ! errors in code, and it also throws a runtime error when the
    ! console input contains anything that can't be violently cast
    ! to an integer value.
    function read_move()
      implicit none
      integer :: column, row
      integer, dimension(2) :: read_move

      write(*,'(A)',advance='no') new_line('A')//"Please enter a column number: "
      read(*,'(i10)') column

      write(*,'(A)',advance='no') "Please enter a row number: "
      read(*,'(i10)') row

      read_move = (/column, row/)
    end function read_move
end module user_input
