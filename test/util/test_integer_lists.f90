module test_integer_lists
  contains
    subroutine test_appending_to_empty_list
      use fruit
      use integer_lists

      implicit none
      integer, allocatable :: given_list(:), expected_list(:)

      expected_list = (/7/)

      allocate(given_list(0))
      call append_to_integer_list(given_list, 7)

      call assert_equals(expected_list, given_list, 1, "Appends to empty list")
    end subroutine test_appending_to_empty_list

    subroutine test_appending_to_populated_list
      use fruit
      use integer_lists

      implicit none
      integer, allocatable :: given_list(:), expected_list(:)

      expected_list = (/1, 2, 3/)

      given_list = (/1, 2/)
      call append_to_integer_list(given_list, 3)

      call assert_equals(expected_list, given_list, 3, "Appends to populated list")
    end subroutine test_appending_to_populated_list
end module test_integer_lists
