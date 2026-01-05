
module TicTacToe
 class Game
  attr_accessor :number_of_players, :board, :round
    def initialize
      @board = [[1,2,3],[4,5,6],[7,8,9]]
      players    
      play
    end

    def players
      puts "How many players? (1 or 2)"
      @number_of_players = gets.chomp.to_i
      if @number_of_players > 2
        puts "Invalid number of players. Please enter 1 or 2."
        players
      end
    end

    def print_board
        puts ""
        @board.each do |row|
         puts row.join(" | ")
         puts "---------" unless row == @board.last
        end

    end


    def play 
      for @round in 1..10 do
        print_board
        check_winner
        if @number_of_players == 1 && @round.odd?
          puts "\nPlayer 1's turn..."
          player_move
        elsif @number_of_players == 1 && @round.even?
          puts "\nPlayer 2's turn..."
          computer_move
        elsif @number_of_players == 2 && @round.odd?
          puts "\nPlayer 1's turn..."
          player_move
        else
          puts "\nPlayer 2's turn..."
          player_move
        end
      end
    end

    def player_move
      if @round.odd? && @number_of_players == 1
        print "Player 1, enter your move (1-9):"
        move = gets.chomp.to_i
      elsif @round.odd? && @number_of_players == 2
        print "Player 1, enter your move (1-9):"
        move = gets.chomp.to_i
      elsif @round.even? && @number_of_players == 2
        print "Player 2, enter your move (1-9):"
        move = gets.chomp.to_i
      end

      @board.each_with_index do |row, i|
        row.each_with_index do |cell, j|
          if cell == move
            row[j] = @round.odd? ? 'X' : 'O'
            return
          end
        end
      end
      puts "Invalid move. Try again."
      player_move

    end


    def computer_move
      available_moves = []
      @board.each do |row|
        row.each do |cell|
          available_moves << cell if cell.is_a?(Integer)
        end
      end
      move = available_moves.sample
      
      @board.each_with_index do |row, i|
        row.each_with_index do |cell, j|
          if cell == move
            row[j] = 'O'
            return
          end
        end
      end
    end


    def check_winner
      winning_combinations = [
        [@board[0][0], @board[0][1], @board[0][2]],
        [@board[1][0], @board[1][1], @board[1][2]],
        [@board[2][0], @board[2][1], @board[2][2]],
        [@board[0][0], @board[1][0], @board[2][0]],
        [@board[0][1], @board[1][1], @board[2][1]],
        [@board[0][2], @board[1][2], @board[2][2]],
        [@board[0][0], @board[1][1], @board[2][2]],
        [@board[0][2], @board[1][1], @board[2][0]]
      ]

      winning_combinations.each do |combination|
        if combination.all? { |cell| cell == 'X' }
          puts "\nPlayer 1 wins!"
          exit
        elsif combination.all? { |cell| cell == 'O' }
          puts "\nPlayer 2 wins!"
          exit
        end
      end

      if @round == 10
        puts "\nIt's a draw!"
        exit
      end
    end

  end 
end

include TicTacToe
game = Game.new