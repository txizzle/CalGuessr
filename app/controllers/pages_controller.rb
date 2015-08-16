class PagesController < ApplicationController
  before_action :authenticate_user!, only: [
    :dashboard
  ]

  def home
    @game = Game.new
  end

  def dashboard
  end
  
  def about
  end

  def highscores
    @games = Game.high_scores
  end
  
end
