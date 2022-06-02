# frozen_string_literal: true

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