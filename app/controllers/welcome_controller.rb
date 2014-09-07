class WelcomeController < ApplicationController
  def index
  	if user_signed_in?
  		render :layout => "application"
  	end
  end
end
