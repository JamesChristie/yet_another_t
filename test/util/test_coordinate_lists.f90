module test_coordinate_lists
  contains
    subroutine test_append_to_emtpy_coord_list
      use fruit
      use coordinate_lists

      implicit none
      integer, dimension (:,:), allocatable :: given_list, expected_list

      expected_list = reshape( &
        (/7, 13/),             &
        (/1, 2/)               &
      )

      allocate(given_list(0, 2))
      call append_to_coordinate_list(given_list, 7, 13)

      call assert_equals(expected_list, given_list, 1, 2, "Appends to empty list")
    end subroutine test_append_to_emtpy_coord_list

    subroutine test_append_to_populated_coord_list
      use fruit
      use coordinate_lists

      implicit none
      integer, dimension (:,:), allocatable :: given_list, expected_list

      expected_list = reshape( &
        (/1, 2, 6,             &
          1, 1, 4/),           &
        (/3, 2/)               &
      )

      given_list = reshape( &
        (/1, 2,             &
          1, 1/),           &
        (/2, 2/)            &
      )

      call append_to_coordinate_list(given_list, 6, 4)

      call assert_equals(expected_list, given_list, 1, 2, "Appends to populated list")
    end subroutine test_append_to_populated_coord_list
end module test_coordinate_lists
