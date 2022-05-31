# frozen_string_literal: false

# creates player object
class Player
  def make_guess(letter)
    letter
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
