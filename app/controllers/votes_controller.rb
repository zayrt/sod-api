class VotesController < ApplicationController
	
  def get_answers params
    arr = []
    params.each do |key, value|
      arr << Answer.find(value.to_s)
    end
    return arr
  end

  def create
    user = User.where(authentication_token: params[:token]).first
    answers = get_answers params[:votes]
    question = answers.first.question
    type = Type.find(question.type_id)
    if type.name != "qcm" && answers.count > 1
      render json: {error: "You can vote for several answers only on qcm" }, status: 422
    end
    render json: type.to_json
	end
end