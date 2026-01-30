#Create a game that is either HUMAN vs COMPUTER or HUMAN vs HUMAN
#The game is called mastermind and it has 12 rounds
#One player will be the CODE MAKER and the other is the CODE BREAKER
#The CODE MAKER makes a code that consists of 4 colors((R)ed, (G)reen, (B)lue, (Y)ellow). The colors can repeat. example: blue, blue, green, yellow
#The CODE BREAKER gets 12 rounds to guess the correct code.
#After each guess the CODE MAKER must give hints to the CODE BREAKER
#The hints are X or O. An X means that there is a color in the correct position and it is the correct color.
#An O means that there is a correct color but in the wrong position
#The position of the hints has NOTHING to do with the position of the pieces.
#If there is an X in position 1 that does not mean that the CODE BREAKER got the correct color and position for position 1.
#If the CODE BREAKER gets all the right colors in the right positions before all the turns are up then the CODE BREAKER wins. Otherwise the CODE MAKER wins
#When playing in single player mode the CODE MAKER is always COMPUTER. The CODE BREAKER is always HUMAN.
#When the COMPUTER is choosing the code, it be at random and the code will not be revealed.
#When the HUMAN is choosing the code, give 2 options:
#Set the code, which will clear the screen so that the 2nd player cannot see the code.
#Choose a different code, which will take the PLAYER back through the code selection process

#The Mastermind board should look like this:
#
#       1|2|3|4|  ----
#
#       R|B|Y|B|  xox-
#
#During the CODE BREAKER turn they should be asked to enter a guess for each position, only using letters instead of words.
#R for red
#B for blue
#G for Green
#Y for yellow

module Mastermind
  class Game
    def initialize(player1, player2, name1, name2)
      @players = [player1.new(self, name1), player2.new(self, name2)]
      @current_player_id = 0
      @board_guess = ["-", "-", "-", "-"]
      @board_hint = []
      @code = []
    end

    attr_reader :current_player_id

    def current_player
      @players[current_player_id]
    end

    def other_player_id
      1 - @current_player_id
    end

    def opponent
      @players[other_player_id]
    end

    def switch_players
      @current_player_id = other_player_id
    end

    def play
      @code = current_player.choose_code
      switch_players
      10.times do
        check_winner(current_player)
        place_guess(current_player)
        @board_hint = give_hint(opponent)
        print_board
      end
      puts "\tNice try #{current_player.name}! But you are not the MASTERMIND!!"
    end

    def print_board
      puts "\n"
      puts "\t   Guess \t| \tHints"
      print "\t "
      print @board_guess.join " | "
      print "\t\t "
      print @board_hint.join ""
      print "\n\n"
    end

    def place_guess(player)
      guess = player.make_guess
      @board_guess = guess
    end

    def give_hint(player)
      opponent.hint(@code, @board_guess)
    end

    def check_winner(player)
      if @board_guess == @code
        puts "\tCongratulations #{current_player.name} is the Mastermind!"
        exit
      end
    end
  end

  class Player
    def initialize(game, name)
      @game = game
      @name = name
    end

    attr_reader :name
  end

  class Code_maker < Player
    def choose_code
      selection = ["r", "g", "b", "y"]
      code = []

      if @name != "Computer"
        print "\t#{@name} Please enter a 4 letter code using: (r)ed, (b)lue, (g)reen, (y)ellow: "
        color = gets.chomp.to_s
        temp_code = color.split("")
        result = temp_code.none? { |color| !selection.include?(color) }

        if color.length != 4
          puts "\tInappropriate code length. Try again"
          choose_code
        elsif result == false
          puts "\tPlease choose (r)ed, (b)lue, (g)reen, (y)ellow. Try again"
          choose_code
        else
          code = color.split("")
          system "clear"
          return code
        end
      else
        selection.each do |select|
          choice = selection.shuffle
          color = choice[0]
          code.push(color)
        end
        return code
      end
    end

    def hint(code, guess)
      code = code
      temp_code = code.dup
      guess = guess
      hint = []
      ohs = []

      exes = code.each_index.select { |pos| hint.push("X") if code[pos] == guess[pos] }

      exes.length.times { |pos| temp_code[exes[pos]] = nil }
      temp_code = temp_code.uniq

      ohs = code.each_index.select { |pos| hint.push("O") if guess.include?(temp_code[pos]) && !temp_code.include?(exes) }

      return hint
    end
  end

  class Code_breaker < Player
    def make_guess
      guess = []
      selection = ["r", "g", "b", "y"]

      print "\t#{@name} Please make a 4 letter guess using (r)ed, (b)lue,(g)reen, (y)ellow: "
      color = gets.chomp.to_s
      temp_guess = color.split("")
      result = temp_guess.none? { |c| !selection.include?(c) }

      if color.length != 4
        puts "\tInappropriate guess length. Try again"
        make_guess
      elsif result == false
        puts "\tPlease choose (r)ed, (b)lue, (g)reen, (y)ellow. Try again"
        make_guess
      else
        guess = color.split("")
        return guess
      end
    end
  end
end

include Mastermind

print "\tPress 1 for Single Player Mode. Press 2 for Dual Player Mode: "
mode = gets.chomp.to_i

if mode == 1
  puts "\tYou have chosen single player mode!"
  print "\tPlease enter your name: "
  name1 = gets.chomp.to_s

  names = ["Computer", name1]
  players = [Code_maker, Code_breaker]
else
  puts "\tYou have selected Dual mode!"
  print "\tPlease enter your name: "
  name1 = gets.chomp.to_s

  print "\tPlease enter your name: "
  name2 = gets.chomp.to_s

  names = [name1, name2].shuffle
  players = [Code_maker, Code_breaker]

  puts "\t#{names[0]} has been selected as the CODE MAKER!"
  puts "\t#{names[1]} has been selected as the CODE BREAKER!"
  puts "\tLets find out whos the ... MASTERMIND!!!!"
end

Game.new(*players, *names).play
