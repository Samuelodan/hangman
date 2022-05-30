# frozen_string_literal: false

# creates player object
class Player
  def make_guess(letter)
    letter
  end
end

class Board
  def initialize
    @wordlist = []
    @chosen_word = []
    @hidden = []
    @ref_chosen = []
  end

  def load_words
    @wordlist = File.read('google-10000-english-no-swears.txt').split("\n")
  end
end
