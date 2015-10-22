module detection
  implicit none

  integer, dimension (3,2), private :: TOP_ROW = reshape( &
    (/1, 2, 3,                                           &
      1, 1, 1/),                                         &
    (/3, 2/)                                             &
  )

  integer, dimension (3,2), private :: MIDDLE_ROW = reshape( &
    (/1, 2, 3,                                               &
      2, 2, 2/),                                             &
    (/3, 2/)                                                 &
  )

  integer, dimension (3,2), private :: BOTTOM_ROW = reshape( &
    (/1, 2, 3,                                               &
      3, 3, 3/),                                             &
    (/3, 2/)                                                 &
  )

  integer, dimension (3,2), private :: LEFT_COLUMN = reshape( &
    (/1, 1, 1,                                                &
      1, 2, 3/),                                              &
    (/3, 2/)                                                  &
  )

  integer, dimension (3,2), private :: MIDDLE_COLUMN = reshape( &
    (/2, 2, 2,                                                  &
      1, 2, 3/),                                                &
    (/3, 2/)                                                    &
  )

  integer, dimension (3,2), private :: RIGHT_COLUMN = reshape( &
    (/3, 3, 3,                                                 &
      1, 2, 3/),                                               &
    (/3, 2/)                                                   &
  )

  integer, dimension (3,2), private :: LEFT_DIAGONAL = reshape( &
    (/1, 2, 3,                                                  &
      1, 2, 3/),                                                &
    (/3, 2/)                                                    &
  )

  integer, dimension (3,2), private :: RIGHT_DIAGONAL = reshape( &
    (/3, 2, 1,                                                   &
      1, 2, 3/),                                                 &
    (/3, 2/)                                                     &
  )

  private sequence_is_win

  contains
    function game_won_for(given_board, player)
      use board, only: BOARD_SIZE

      implicit none
      integer :: player
      integer, dimension (BOARD_SIZE,BOARD_SIZE) :: given_board
      logical :: game_won_for

      game_won_for = sequence_is_win(given_board, TOP_ROW,        player) &
                .or. sequence_is_win(given_board, MIDDLE_ROW,     player) &
                .or. sequence_is_win(given_board, BOTTOM_ROW,     player) &
                .or. sequence_is_win(given_board, LEFT_COLUMN,    player) &
                .or. sequence_is_win(given_board, MIDDLE_COLUMN,  player) &
                .or. sequence_is_win(given_board, RIGHT_COLUMN,   player) &
                .or. sequence_is_win(given_board, LEFT_DIAGONAL,  player) &
                .or. sequence_is_win(given_board, RIGHT_DIAGONAL, player)
    end function game_won_for

    function game_lost_for(given_board, player)
      use board, only: BOARD_SIZE

      implicit none
      integer :: player
      integer, dimension (BOARD_SIZE,BOARD_SIZE) :: given_board
      logical :: game_lost_for

      game_lost_for = .not. game_won_for(given_board, player)
    end function game_lost_for

    function sequence_is_win(given_board, given_sequence, player)
      use board, only: BOARD_SIZE

      implicit none
      integer :: i, owner, player
      integer, dimension (BOARD_SIZE,BOARD_SIZE) :: given_board
      integer, dimension (BOARD_SIZE, 2) :: given_sequence
      logical, dimension (BOARD_SIZE) :: claimed_for_player
      logical :: sequence_is_win

      do i=1, BOARD_SIZE
        owner = given_board(    &
          given_sequence(i, 1), &
          given_sequence(i, 2)  &
        )

        claimed_for_player(i) = owner == player
      end do

      sequence_is_win = all(claimed_for_player)
    end function sequence_is_win
end module detection
