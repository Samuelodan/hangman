# frozen_string_literal: true

require './board'

# handles the flow of the game
class Game
  attr_reader :board
  attr_accessor :chances

  def initialize
    @board = Board.new
    @chances = nil
  end

  def set_chances
    self.chances = board.chosen_word.length - 1
  end

  def chances_left
    return if board.correct

    puts "Chances left: #{chances}"
    self.chances -= 1
  end

  def console_player
    reveal_word
    puts 'Gameover, you failed to guess the word in time. Hit "run" to play again'
  end

  def congrats
    reveal_word
    puts 'Yoohoo! You guessed it, good job!'
  end

  def reveal_word
    hidden_word = board.ref_chosen.join
    puts "The secret word was: \"#{hidden_word}\""
  end

  def handle_guess
    board.display_hint
    chances_left
    board.player.make_guess
    board.validate_guess
    board.check_win
    return congrats if board.win
  end

  def start
    board.choose_word
    set_chances
    # chances.times do
    until board.win
      break if chances.zero?

      handle_guess
    end
    console_player
  end
end
