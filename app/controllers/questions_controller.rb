class QuestionsController < ApplicationController
	
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
			render json: {success: "Your question have been created." }, status: 201
		else
			render json: {error: question.errors }, status: 422
		end
	end 

	def destroy
		q = Question.find(params[:id])
		user = User.where(authentication_token: params[:token]).first
		if !q.nil? && q.destroy
			render json: {success: "Your question have been destroyed." }
		else
			render json: {error: "Your question can't be destroyed." }
		end
	end

	private

	def question_params
		params.require(:question).permit(:name, :type_id)
	end

end
