class VotesController < ApplicationController
	
  def get_answers params
    arr = []
    params.each do |key, value|
      arr << value.to_s
    end
    return arr
  end

  def create
    user = User.where(authentication_token: params[:token]).first
    question = Answer.find(params[:votes].first.last).question
    type = Type.find(question.type_id)
    if user.nil?
      render json: {error: "Invalidate token. You must sign in."}, status: 422
    elsif type.name != "qcm" && params[:votes].count > 1
      render json: {error: "You can vote for several answers only for a qcm" }, status: 422
    else
      vote = Vote.new(question_id: question.id, user_id: user.id)
      #vote.answers_ids = get_answers params[:votes]
      vote.save
      vote.update(answers_ids: get_answers(params[:votes]))
      render json: vote.to_json
    end
	end
end