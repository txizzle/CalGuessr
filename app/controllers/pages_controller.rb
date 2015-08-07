class PagesController < ApplicationController
  before_action :authenticate_user!, only: [
    :inside
  ]

  def home
    @game = Game.new
  end

  def inside
  end
  
  def about
  end

  def highscores
    @games = Game.high_scores
  end
  
end
