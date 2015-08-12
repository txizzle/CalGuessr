class Admin::BaseController < ApplicationController


  def index
    @last_signups = User.last_signups(10)
    @last_signins = User.last_signins(10)
    @count = User.users_count

  end
end
