class PagesController < ApplicationController
require 'open-uri'
require 'json'
require 'date'

def generate_grid(grid_size)
  grid = []
  grid_size.times do
    grid << ("A".."Z").to_a.sample
  end
  return grid
  # TODO: generate random grid of letters
end



  def game
    @grid = generate_grid(10)
  end

  def score
    @attempt = params[:guess]
    @result = run_game(@attempt, params[:grid].split(""), params[:time].to_i, Time.now.to_i)
  end


def run_game(attempt, grid, start_time, end_time)
  url = "https://wagon-dictionary.herokuapp.com/#{attempt}"
  site = open(url).read
  dictionary = JSON.parse(site)
  result = {}
  result[:time] = end_time - start_time
  if dictionary["found"] == false
    result[:score] = 0
    result[:message] = "Not an english word"
  elsif attempt.upcase.split("") & grid != attempt.upcase.split("")
    result[:score] = 0
    result[:message] = "not in the grid"
  else
    result[:score] = attempt.length - result[:time]
    result[:message] = "Well Done"
  end
  return result
  # TODO: runs the game and return detailed hash of result
end

end
