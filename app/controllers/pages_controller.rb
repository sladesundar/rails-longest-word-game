
class PagesController < ApplicationController
  def game
   $grid = Array.new(9) { ('A'..'Z').to_a.sample }
   @start_time = Time.now.to_i
  end

  def score

  # TODO: runs the game and return detailed hash of result
      @attempt = params[:user_guess].upcase
      start_time = params[:start_time].to_i

      end_time = Time.now.to_i
      @total_time = end_time - start_time

     if included?(@attempt, $grid)
      if english_word?(@attempt)
        @score = (@attempt.length / @total_time.to_f) * 100
        @message = "well done!"

      else
        @score = "0"
        @message = "not an english word"
      end
    else
      @score = "0"
      @message = "not in grid"
    end
  end

def included?(guess, grid)
  guess.chars.all? { |letter| guess.count(letter) <= grid.count(letter) }
end


def english_word?(word)
  response = open("https://wagon-dictionary.herokuapp.com/#{word}")
  json = JSON.parse(response.read)
  return json['found']
end

end
