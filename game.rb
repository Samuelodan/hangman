# frozen_string_literal: true

require './board'
require 'json'

# handles the flow of the game
class Game
  attr_reader :board
  attr_accessor :chances

  def initialize
    @board = Board.new
    @chances = nil
  end

  def set_chances
    return if chances

    self.chances = board.chosen_word.length - 1
  end

  def chances_left
    return if board.correct

    puts "#{chances} strike(s) left"
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

  def save_game
    puts 'To save the game, enter "yes" or enter "no" to proceed without saving.'
    answer = gets.chomp.downcase
    until answer.match?(/^[a-z]{2,3}$/)
      puts 'enter "yes" or enter "no" to proceed without saving.'
      answer = gets.chomp.downcase
    end
    case answer
    when 'yes' then to_json
    when 'no' then puts 'game not saved.'
    else puts 'You have not provided a valid input, proceeding without saving.'
    end
  end

  def start
    board.choose_word
    set_chances
    # chances.times do
    until board.win
      break if chances.zero?

      handle_guess
    end
    console_player unless board.win
  end
end
