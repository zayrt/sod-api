class PagesController < ApplicationController
  def index
  end

  def get_all_types
  	render json: Type.all.to_json
  end

  def vote
  	@question = Question.all
  	if user_signed_in?
  		@votes = Vote.where(user_id: current_user.id)
  	end
  end
end
