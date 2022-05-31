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
    @chosen_word = @wordlist.sample
    @ref_chosen = @chosen_word
  end
end
