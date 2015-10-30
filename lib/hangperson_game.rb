class HangpersonGame

  # add the necessary class methods, attributes, etc. here
  # to make the tests in spec/hangperson_game_spec.rb pass.

  # Get a word from remote "random word" service

  # def initialize()
  # end
  
  attr_accessor :word, :guesses, :wrong_guesses
  
  def initialize(word)
    @word = word
    @guesses = ''
    @wrong_guesses = ''
  end

  def self.get_random_word
    require 'uri'
    require 'net/http'
    uri = URI('http://watchout4snakes.com/wo4snakes/Random/RandomWord')
    Net::HTTP.post_form(uri ,{}).body
  end
  
  def guess(letter)
    raise ArgumentError if letter.nil? or letter.empty? or /(^\W+$)/.match(letter)
    ltr = letter.downcase
    if (@word.include? ltr) && (not @guesses.include? ltr)
      @guesses += ltr
      return true
    end
    if (not @word.include? ltr) && (not @wrong_guesses.include? ltr)
      @wrong_guesses += ltr
      return true
    end
    return false
  end
  
  def word_with_guesses
    s = ''
    @word.split(//).each do |c|
      if @guesses.include? c
        s += c
      else
        s += '-'
      end
    end
    return s
  end
  
  def check_win_or_lose
    return :win if word_with_guesses.eql? @word
    return :lose if @guesses.length + @wrong_guesses.length >= 7
    return :play
  end

end



