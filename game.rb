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
    save_game
    chances_left
    board.player.make_guess
    board.validate_guess
    board.check_win
    return congrats if board.win
  end

  def to_json
    Dir.mkdir('progress') unless Dir.exist?('progress')

    File.open('progress/game_data.json', 'w') do |file|
      file.puts JSON.dump({
                            board: board.to_hash,
                            chances: chances
                          })
    end
  end

  def from_json
    File.open('progress/game_data.json', 'r') do |file|
      data = JSON.load file
      self.chances = data['chances']
      board.chosen_word = data['board']['chosen_word']
      board.hidden = data['board']['hidden']
      board.ref_chosen = data['board']['ref_chosen']
      board.win = data['board']['win']
      board.correct = data['board']['correct']
    end
  end

  def ask_yes_no
    input = gets.chomp.downcase
    until input.match?(/^[a-z]{2,3}$/)
      puts 'enter "yes" or "no" to proceed.'
      input = gets.chomp.downcase
    end
    input
  end

  def save_game
    puts 'To save the game, enter "yes" or enter "no" to proceed without saving.'
    answer = ask_yes_no
    case answer
    when 'yes'
      to_json
      puts 'progress saved...'
    when 'no' then puts 'game not saved...'
    else puts 'You have not provided a valid input, proceeding without saving...'
    end
  end

  def load_game
    puts "Do you want to load previous progress?\nenter 'yes' or 'no' to continue"
    answer = ask_yes_no
    case answer
    when 'yes'
      from_json
      puts 'Now, you will continue from previous save...'
    when 'no' then puts 'continuing current run...'
    else puts 'You have not provided a valid input, proceeding without loading...'
    end
  end

  def start
    load_game
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
