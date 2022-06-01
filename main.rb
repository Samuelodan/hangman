# frozen_string_literal: false

# creates player object
class Player
  attr_accessor :guess

  def initialize
    @guess = ''
  end

  def make_guess
    puts 'Enter a letter you think is included in the secret word'
    letter = gets.chomp.downcase
    until letter.match?(/^[a-z]{1}$/)
      puts 'guess must be only one English letter'
      letter = gets.chomp.downcase
    end
    self.guess = letter
  end
end

# creates board class that has most of the game's functionality
class Board
  def initialize
    @wordlist = []
    @chosen_word = []
    @hidden = []
    @ref_chosen = []
  end

  def load_words
    words = File.read('google-10000-english-no-swears.txt').split("\n")
    @wordlist = words.select { |w| w.length.between?(5, 12) }
  end

  def choose_word
    @chosen_word = @wordlist.sample.split('')
    @ref_chosen = @chosen_word
  end

  def display_hint
    @hidden = Array.new(@chosen_word.length) { '—' } if @hidden.empty?
    puts @hidden
  end
end
