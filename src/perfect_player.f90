! NOTE (JamesChristie) For comparison, this is a roghly identical implementation
! to what is seen here:
! https://github.com/JamesChristie/minimax_kata/blob/kata/minimax_kata/minimax_solver.py
module perfect_player
  use board, only: BOARD_SIZE
  use detection

  implicit none

  integer, parameter :: WIN_SCORE = 10
  integer, parameter :: LOSS_SCORE = -10
  integer, parameter :: TIE_SCORE = 0

  type minimax_step
    integer :: proxied_player, current_player
    integer :: depth = 0
    integer, dimension (BOARD_SIZE,BOARD_SIZE) :: current_board

    contains
      procedure :: get_opponent
      procedure :: get_best_moves
      procedure :: get_max_score
      procedure, private :: get_score_list
      procedure, private :: get_score_for_move
      procedure, private :: calculate_score
  end type minimax_step

  contains
    ! Command function
    ! ----------------
    function best_moves(given_board, player)
      use board, only: BOARD_SIZE

      implicit none
      integer :: player
      type(minimax_step) :: ai_solver
      integer, dimension (BOARD_SIZE,BOARD_SIZE) :: given_board
      integer, dimension (:,:), allocatable :: best_moves

      ai_solver = minimax_step(    &
        current_board=given_board, &
        proxied_player=player,     &
        current_player=player      &
      )

      best_moves = ai_solver%get_best_moves()
    end function best_moves

    ! Instance methods of minimax_step
    ! --------------------------------
    function get_opponent(this)
      class(minimax_step) :: this
      integer :: get_opponent

      if (this%proxied_player /= 1) then
        get_opponent = 1
      else
        get_opponent = 2
      end if
    end function get_opponent

    function get_best_moves(this)
      use board
      use coordinate_lists

      implicit none
      class(minimax_step) :: this
      integer :: i, max_score
      integer, dimension (:,:), allocatable :: available_moves
      integer, allocatable :: score_list(:)
      integer, dimension (:,:), allocatable :: get_best_moves

      allocate(get_best_moves(0, 2))
      available_moves = valid_moves(this%current_board)
      score_list = this%get_score_list()
      max_score = this%get_max_score()

      do i=1, size(available_moves, 1)
        if (score_list(i) == max_score) then
          call append_to_coordinate_list( &
            get_best_moves,               &
            available_moves(i, 1),        &
            available_moves(i, 2)         &
          )
        end if
      enddo
    end function get_best_moves

    function get_max_score(this)
      implicit none
      class(minimax_step) :: this
      integer :: get_max_score

      get_max_score = maxval(this%get_score_list())
    end function get_max_score

    function get_score_list(this)
      use board
      use integer_lists

      implicit none
      class(minimax_step) :: this
      integer :: i, temp_score
      integer, dimension (BOARD_SIZE,BOARD_SIZE) :: temp_board
      integer, dimension (:,:), allocatable :: available_moves
      integer, allocatable :: get_score_list(:)

      allocate(get_score_list(0))
      available_moves = valid_moves(this%current_board)

      do i=1, size(available_moves, 1)
        temp_board = apply_move( &
          this%current_board,    &
          this%current_player,   &
          available_moves(i,1),  &
          available_moves(i,2)   &
        )

        temp_score = this%get_score_for_move(temp_board)
        call append_to_integer_list(get_score_list, temp_score)
      enddo
    end function get_score_list

    function get_score_for_move(this, given_board)
      implicit none
      class(minimax_step) :: this
      integer, dimension (BOARD_SIZE,BOARD_SIZE) :: given_board
      integer :: get_score_for_move

      if (game_won_for(given_board, this%proxied_player)) then
        get_score_for_move = WIN_SCORE
      else if (game_lost_for(given_board, this%proxied_player)) then
        get_score_for_move = LOSS_SCORE
      else if (game_is_tie(given_board)) then
        get_score_for_move = TIE_SCORE
      else
        get_score_for_move = this%calculate_score(given_board)
      end if
    end function get_score_for_move

    function calculate_score(this, given_board)
      implicit none
      class(minimax_step) :: this
      type(minimax_step) :: next_step
      integer, dimension (BOARD_SIZE,BOARD_SIZE) :: given_board
      integer :: calculate_score

      if (this%current_player == this%proxied_player) then
        next_step = minimax_step(             &
          current_board=given_board,          &
          proxied_player=this%proxied_player, &
          current_player=this%get_opponent(), &
          depth=this%depth + 1                &
        )

        calculate_score = -(next_step%get_max_score() - this%depth)
      else
        next_step = minimax_step(             &
          current_board=given_board,          &
          proxied_player=this%proxied_player, &
          current_player=this%proxied_player, &
          depth=this%depth + 1                &
        )

        calculate_score = next_step%get_max_score() - this%depth
      end if
    end function calculate_score
end module perfect_player
