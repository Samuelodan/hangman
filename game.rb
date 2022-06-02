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
    self.chances = (board.chosen_word.length * 1.5).to_i
  end

  def chances_left
    puts "Chances left: #{chances}"
    self.chances -= 1
  end
end
