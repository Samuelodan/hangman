# frozen_string_literal: true

require './player'

# creates board object that has most of the game's functionality
class Board
  attr_accessor :wordlist, :chosen_word, :hidden, :ref_chosen, :win, :correct
  attr_reader :player

  def initialize
    @wordlist = []
    @chosen_word = []
    @hidden = []
    @ref_chosen = []
    @player = Player.new
    @win = false
    @correct = true
    load_words
  end

  def load_words
    return unless wordlist.empty?

    words = File.read('google-10000-english-no-swears.txt').split("\n")
    self.wordlist = words.select { |w| w.length.between?(5, 12) }
  end

  def choose_word
    return unless chosen_word.empty?

    self.chosen_word = wordlist.sample.split('')
    self.ref_chosen = chosen_word.clone
  end

  def display_hint
    self.hidden = Array.new(@chosen_word.length) { '—' } if hidden.empty?
    p hidden
  end

  def validate_guess
    guess = player.guess
    if chosen_word.include?(guess)
      puts 'Correct! Nice!'
      self.correct = true
      update_hint(guess)
    else
      puts 'oops! try another letter'
      self.correct = false
    end
  end

  def update_hint(guess)
    index = chosen_word.index(guess)
    hidden[index] = chosen_word[index]
    chosen_word[index] = '—'
  end

  def check_win
    self.win = true unless hidden.include?('—')
  end

  def to_hash
    {
      chosen_word: chosen_word,
      hidden: hidden,
      ref_chosen: ref_chosen,
      win: win,
      correct: correct
    }
  end
end
