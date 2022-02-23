
require 'json'
require 'yaml'
word_file = File.open('google-10000-english-no-swears.txt', "r")

class Display

  attr_accessor :secret_word, :array_of_words, :board, :turn

  def initialize
    @array_of_words = []
    @secret_word = nil
    @board = []
    @turn = nil
  end

  def get_new_word
    
  end

  def to_yaml
    YAML.dump ({
      :secret_word => @secret_word,
      :board => @board,
      :turn => @turn
    })
  end

  def from_yaml(string)
    data = YAML.load string
    data
    @secret_word = data[:secret_word]
    @board = data[:board]
    @turn = data[:turn]
  end

  def to_json
    JSON.dump ({
      :secret_word => @secret_word,
      :board => @board,
      :turn => @turn      
    })
  end

  def from_json(string)
    data = JSON.load string
    data
    @secret_word = data["secret_word"]
    @board = data["board"]
    @turn = data["turn"]
  end

  def save_game
    save_file = File.open("save_file.txt", "w")
    save_file.write to_json
    save_file.close
  end

  def load_game
    file = File.open("save_file.txt", "r")
    contents = file.read

    from_json(contents)
  end

  def get_words(word_file)

    word_file.each do |word|
      if word.length.between?(5,12)
        @array_of_words << word
      end
    end
  end

  def get_secret_word(word_file)
    puts "array of words: #{array_of_words}"
    get_words(word_file)
    puts "array of words: #{array_of_words}"
    index = rand(0..array_of_words.length)
    puts "Array of words length: #{array_of_words.length}"
    @secret_word = array_of_words[index].chomp
    @secret_word = word_to_array
  end

  def word_to_array
    word_array = secret_word.split('')
  end

  def starting_board
    @board = Array.new(secret_word.length, '_')
    board.join(' ')
  end

  def new_or_save_text
    puts "Let's play Hangman!"
    puts "Type 'new' for new game or 'load' to load a previously saved game."
  end

  def intro_text
    @turn = 10
    puts "The evil computer has selected a secret word."
    puts "Can you guess it in less than 10 tries?"
  end

  def turn_text
    puts "Turns left: #{turn}. Type a single letter to guess. Type 'save' to save and quit."
  end
end

# display = Display.new
# puts display.get_secret_word(word_file)
# puts display.starting_board