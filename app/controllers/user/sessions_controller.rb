class User::SessionsController < Devise::SessionsController
	def create
    user = User.where(email: params[:user][:email]).first
    if user.nil? || !user.valid_password?(params[:user][:password])
      render json: {error: "Login/password incorrect."}, status: 422
    else
      render json: {success: {token: user.authentication_token}}, status: 201
    end
  end

  def destroy
  	user = User.where(authentication_token: params[:token]).first
  	if user.nil?
  		render json: {error: "Invalidate token."}, status: 422
  	else	
    	user.update(authentication_token: nil)
    	render json: {success: "You has been disconnect, your token doesn't exist anymore."}, status: 200
  	end
  end
end