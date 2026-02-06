# The program is going to be the hangman game.
# This game will pick the words randomly from the dictionary document.
# The game will be single player
# This program will be able to save any game and load game based on game id
# The values that are stored in the yaml file that constitue the game are:
# game_id, word_selected, correct_guesses, wrong_guesses
# The game will draw a hangman as the player wrong guesses

# ----
# |   |
# |   O
# |  /|\
# |   |
# |  / \
# |

#  or

# 1 2 3 4 5 6 7 8 9 10
# x x x x x x x x x x

require "yaml"

module Hangman
  class Game
    def initialize(word_selected, correct_guesses, wrong_guesses)
      word = word_selected
      @word_selected = format_word(word)
      length = @word_selected.length
      @correct_guesses = Array.new(length, "-")
      @wrong_guesses = wrong_guesses
    end

    def play
      print "Press 1 for a new game. Press 2 to load a previously saved game.: "
      selection = gets.chomp.to_i

      case selection
      when 1
        print_game
        while @wrong_guesses.length < 10
          check_winner(@correct_guesses)
          guess = make_guess
          check_guess(guess)
          print_game
        end
      when 2
        load_game
        print_game
        while @wrong_guesses.length < 10
          check_winner(@correct_guesses)
          guess = make_guess
          check_guess(guess)
          print_game
        end
      end
    end

    def save_game
      game_info = {
        "game" => {
          "word_selected" => @word_selected,
          "correct_guesses" => @correct_guesses,
          "wrong_guesses" => @wrong_guesses,
        },
      }

      # 2. Write the YAML string to a file using File.write
      File.write("game_info.yml", game_info.to_yaml)

      puts "Your game has been saved!"
      exit
    end

    def load_game
      game = YAML.load_file("game_info.yml")
      word = game["game"]["word_selected"]
      @word_selected = format_word(word)
      @correct_guesses = game["game"]["correct_guesses"]
      @wrong_guesses = game["game"]["wrong_guesses"]
    end

    def make_guess
      print "\nPress 1 to save your games progress or choose your next letter: "
      guess = gets.chomp

      if @correct_guesses.any?(guess)
        puts "This is already on the board! Guess again!"
        make_guess
      elsif @wrong_guesses.any?(guess)
        puts "Invalid selection! Guess again!"
        make_guess
      elsif guess == "1"
        save_game
      else
        return guess
      end
    end

    def check_guess(guess)
      word = @word_selected.split("")
      guess_word = guess.split("")

      if guess_word == word
        check_winner(guess_word)
      elsif @word_selected.include?(guess) == true
        start_pos = -1

        while (start_pos = @word_selected.index(guess, start_pos + 1))
          @correct_guesses[start_pos] = guess
        end
      else
        @wrong_guesses.push(guess)
      end
    end

    def check_winner(guess)
      word = @word_selected.split("")
      if guess == word
        puts "Congratulations you win!"
        puts "  _\\|/_   _\\|/_   _\\|/_"
        puts "   /|\\     /|\\     /|\\"
        puts "    |       |       |"
        exit
      end
    end

    def print_game
      puts "\nWord of the day: #{@correct_guesses.join("")}"
      print_hangman
      puts "\nIncorrect Letters: #{@wrong_guesses.join(",")}"
    end

    def format_word(word)
      word = word
      word_array = word.split("")
      word_array.delete_at(-1)

      return word_array.join("")
    end

    def print_hangman
      case @wrong_guesses.length
      when 1
        puts "
              |
              |
              |
              |
              |
              |"
      when 2
        puts "
              -----
              |
              |
              |
              |
              |
              |"
      when 3
        puts "
              -----
              |    |
              |
              |
              |
              |
              |"
      when 4
        puts "
              -----
              |    |
              |    0
              |
              |
              |
              |"
      when 5
        puts "
              -----
              |    |
              |    0
              |   /
              |
              |
              |"
      when 6
        puts "
              -----
              |    |
              |    0
              |   /|
              |
              |
              |"
      when 7
        puts "
              -----
              |    |
              |    0
              |   /|\\  
              |
              |
              |"
      when 8
        puts "
              -----
              |    |
              |    0
              |   /|\\
              |    |
              |
              |"
      when 9
        puts "
              -----
              |    |
              |    0
              |   /|\\
              |    |
              |   /
              |"
      when 10
        puts "
              -----
              |    |
              |    0
              |   /|\\
              |    |
              |   / \\
              |"
        puts "The word of the day is: #{@word_selected}"
        puts "You have run out of guesses. Sorry you lose!"
      end
    end
  end
end

include Hangman

word_array = Array.new
File.foreach("dictionary.txt") do |line|
  word_array.push(line)
end
word = word_array.sample

puts "\t\t\tLets play hangman!"
Game.new(word, Array.new, Array.new).play
