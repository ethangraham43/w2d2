class Hangman
  DICTIONARY = ["cat", "dog", "bootcamp", "pizza"]
  def self.random_word
    DICTIONARY.sample
  end
  def initialize
    @secret_word = Hangman.random_word
    @guess_word = Array.new(@secret_word.length, "_")
    @attempted_chars  = []
    @remaining_incorrect_guesses = 5
  end

  def guess_word
    @guess_word
  end
  
  def attempted_chars
    @attempted_chars
  end

  def remaining_incorrect_guesses
    @remaining_incorrect_guesses
  end

  def already_attempted?(char)
    if attempted_chars.include?(char)
      return true
    else
      return false
    end
  end

  def get_matching_indices(char)
    ret_arr = []

    @secret_word.each_char.with_index do |let, idx|
      if char == let
        ret_arr << idx
      end
    end
    ret_arr
  end

  def fill_indices(char, arr)
    arr.each do |idx|
      @guess_word[idx] = char
    end
  end

  def try_guess(char)
    if self.already_attempted?(char)
      p "that has already been attempted"
      return false
    else
      @attempted_chars << char

      self.fill_indices(char, self.get_matching_indices(char))
      @remaining_incorrect_guesses -= 1 if self.get_matching_indices(char).empty?

      return true
    end
  end

  def ask_user_for_guess
    p "Enter a char:"
    user_in = gets.chomp
    try_guess(user_in) 
  end
  
  def win?
    if @guess_word.join("") == @secret_word
      p "WIN"
      return true
    else
      return false
    end
  end

  def lose?
    if @remaining_incorrect_guesses == 0
      p "LOSE"
      return true
    else
      return false
    end
  end

  def game_over?
    if self.lose? || self.win?
      p @secret_word
      return true
    else
      return false
    end
  end

end
