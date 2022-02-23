word_file = File.open('google-10000-english-no-swears.txt', "r")

require 'yaml'
require 'json'
require_relative 'display.rb'
require 'active_support/core_ext/enumerable.rb'

class Game

  attr_accessor :display, :game_over

  def initialize(display)
    @display = display
    @game_over = false
  end

  # def to_yaml
  #   YAML.dump ({
  #     :display => @display,
  #     # :game_over => @game_over
  #   })
  # end

  # def save_game
  #   save_file = File.open("save_file.txt", "w")
  #   save_file.write to_yaml
  #   save_file.close
  # end

  # def from_yaml(string)
  #   data = YAML.load string
  #   # p data
  #   # display.board = data[@board]
  #   # display.secret_word = data[@secret_word]
  #   # display.turn = data[@turn]
  #   p data[@board]
  # end

  # def load_game
  #   file = File.open("save_file.txt", "r")
  #   contents = file.read

  #   from_yaml(contents)
  # end

  def intro_input(word_file)
    input = gets.chomp

    if input == 'new'
      display.get_secret_word(word_file)
      display.intro_text
      display.starting_board
    elsif input == 'load'
      display.load_game
    else
      puts "Please type either 'new' or 'load'."
    end
  end

  def turn_input
    input = gets.chomp.downcase
    
    if input.length == 1
      check_for_match(input)
    elsif input == 'save'
      display.save_game
      abort('See you soon!')
    else
      puts "Enter a letter as a guess or type 'save and quit'."
      turn_input
    end
  end

  def check_for_match(input)
    index_of_matches = display.secret_word.each_index.select{|i| display.secret_word[i] == input}
      
    if index_of_matches.length > 0
      index_of_matches.each do |index|
        display.board[index] = input
      end
    else
      puts "No letter found."
      display.turn -= 1
    end
  end

  def turn
    display.turn_text
    puts display.board.join(' ')
    turn_input
    game_status
  end

  def game_status
    if display.board.exclude?('_')
      @game_over = true
      puts display.board.join(' ')
      puts "YOU WIN! You guessed the evil computer's secret word!"
    elsif display.turn == 0
      @game_over = true
      puts "You lose. Better luck next time!"
    end
  end

  def play(word_file)
    display.new_or_save_text
    intro_input(word_file)
    until game_over == true do
      turn
    end
  end
end


#TO-DO:
#Figure out replay 'y'
#For some reason, display.rb array_of_words.length returns 0
#on replay.
#save and quit method
#load and play method