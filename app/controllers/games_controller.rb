require 'open-uri'
require 'json'

class GamesController < ApplicationController
  def new
    @letters = ('A'..'Z').to_a.shuffle[0,10]
  end


  def included?(word, letters)
    word.chars.all? { |letter| word.count(letter) <= letters.count(letter) }
  end

  def english_word?(word)
    response = open("https://wagon-dictionary.herokuapp.com/#{word}")
    json = JSON.parse(response.read)
    return json['found']
  end

  def score
    @letters = params[:letters].split(" ")
    @word = params[:word].upcase
    @included = included?(@word, @letters)
    @english = english_word?(@word)
    
    # binding.pry
    

    
  end
end
