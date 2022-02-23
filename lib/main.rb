
word_file = File.open('google-10000-english-no-swears.txt', "r")

require 'yaml'
require 'json'
require_relative 'game.rb'
require_relative 'display.rb'

def replay(game, word_file)
  puts "Would you like to play again? Type 'y' or 'n'."

  response = gets.chomp
  if response != 'y' && response != 'n'
    puts "Would you like to play again? Type 'y' or 'n'."
    replay
  elsif response == 'y'
    game.game_over = false
    game.play(word_file)
  elsif response == 'n'
    puts "Thanks for playing!"
  end
end

game = Game.new(Display.new)

game.play(word_file)
replay(game, word_file)
# game.load_game