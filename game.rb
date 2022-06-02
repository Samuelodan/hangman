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
    self.chances = board.chosen_word.length * 2
  end

  def chances_left
    puts "Chances left: #{chances}"
    self.chances -= 1
  end

  def congrats
    reveal_word
    puts 'Yoohoo! You guessed the word, good job!'
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
    # if board.correct
    #   # call next method
    # else
    #   handle_guess
    # end
  end

  def start
    board.choose_word
    set_chances
    chances.times do
      handle_guess
    end
  end
end
