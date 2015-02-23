class QuestionsController < ApplicationController
	
	def index
		render json: Question.all.to_json
	end

	def show
		q = Question.find(params[:id])
		if q.nil?
			render json: {error: "Your question doesn't exist." }, status: 422
		else
			h = {question: q, answers: q.answers}
			render json: h.to_json
		end
	end

	def create
		user = User.where(authentication_token: params[:token]).first
		question = Question.new question_params
		if user.nil?
			render json: {error: "Invalidate token. You must sign in."}, status: 422
		elsif !user.questions.where(name: params[:question][:name]).first.nil?
			render json: {error: "You have already created this question."}, status: 422
		elsif question.save
			params[:question].each do |key, value|
				if key.to_s != "name" && key.to_s != "type_id"
					answer = Answer.new(name: value)
					answer.question_id = question.id
					answer.save
				end
			end
			question.update(user_id: user.id)
			render json: {success: "Your question have been created." }, status: 200
		else
			render json: {error: question.errors }, status: 422
		end
	end 

	def destroy
		q = Question.find(params[:id])
		user = User.where(authentication_token: params[:token]).first
		if q.nil? 
			render json: {error: "Your question doesn't exist." }, status: 422
		elsif user.nil? || q.user_id != user.id
			render json: {error: "You can destroy only your question." }, status: 422
		elsif q.destroy
			render json: {success: "Your question have been destroyed." }, status: 200
		else
			render json: {error: "Your question can't be destroyed." }, status: 422
		end
	end

	private

	def question_params
		params.require(:question).permit(:name, :type_id)
	end

end
