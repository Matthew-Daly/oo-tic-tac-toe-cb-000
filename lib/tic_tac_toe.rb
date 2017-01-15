class TicTacToe

  #initialize game with empty game board
  def initialize(board = [" ", " ", " ", " ", " ", " ", " ", " ", " "])
    @board = board
  end


  # Define WIN_COMBINATIONS constant
   WIN_COMBINATIONS = [
     [0,1,2], #top row
     [3,4,5], #middle row
     [6,7,8], #bottom row
     [0,3,6], #left column
     [1,4,7], #middle column
     [2,5,8], #right column
     [0,4,8], #diagonal left right
     [2,4,6]  #diagonal right left
   ]

   #diplay current state of board
   def display_board
     puts " #{@board[0]} | #{@board[1]} | #{@board[2]} "
     puts "-----------"
     puts " #{@board[3]} | #{@board[4]} | #{@board[5]} "
     puts "-----------"
     puts " #{@board[6]} | #{@board[7]} | #{@board[8]} "
   end

   #ask for and validates and makes players move
   def turn
     puts "Please enter 1-9:"
     input = gets.strip
     index = input_to_index(input)
     if valid_move?(index)
       move(index, current_player)
       display_board
     else
       turn
     end
   end

   #Over arching play method
   def play
     while !over?
       turn
     end
     if won?
       puts "Congratulations #{winner}!"
     else
       puts "Cat's Game!"
     end
   end


   #change user's input into an board index
   def input_to_index(user_input)
     user_input.to_i - 1
   end

   #inputs player's move on to board array
   def move(index, current_player)
     @board[index] = current_player
   end

   #returns the current player "X" or "O"
   def current_player
     turn_count == 0 || turn_count % 2 == 0 ? "X" : "O"
   end

   #determines if space is filled
   def position_taken?(location)
     @board[location] != " " && @board[location] != ""
   end

   #determines if move is valid
   def valid_move?(index)
     index.between?(0,8) && !position_taken?(index)
   end

   #counts the number of turns already taken
   def turn_count
     num_turns = 0
     @board.each do |space|
       if space == "X" || space == "O"
         num_turns += 1
       end
     end
     return num_turns
   end

   #Compare current state of board with WIN_COMBINATIONS array to determine if there has been a winner
   $win_condition = WIN_COMBINATIONS.detect do |win_cond|
     [win_cond[0]] == [win_cond[1]]&&
     [win_cond[0]] == [win_cond[2]]&&
     position_taken?(win_cond[0])
   end

   #check if the game has been won
   def won?
     if @board.all? { |i| i == "" || i == " "} == true
       return false
     end
     WIN_COMBINATIONS.detect do |win_cond|
       @board[win_cond[0]] == @board[win_cond[1]]&&
       @board[win_cond[0]] == @board[win_cond[2]]&&
       position_taken?(win_cond[0])
     end
   end

   #Check to see if board is full
   def full?
     if @board.detect{|i| i == "" || i == " "}
       return false
     else
       return true
     end
   end

   #Check to see if game board is full
   def draw?
     !won? && full? ? true : false
   end

   #Determine if game is over
   def over?
     if won? != false && won? != nil || draw? == true
       return true
     else
       return false
     end
   end

   #Determine the winner of the game
   def winner
     if won? != false && won? != nil
       win = won?
       return @board[win[0]]
     else
       return nil
     end
   end

 end
