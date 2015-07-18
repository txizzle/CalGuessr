class PagesController < ApplicationController
  before_action :authenticate_user!, only: [
    :inside
  ]

  def home
    @game = Game.new
  end

  def inside
  end
  
  
end
