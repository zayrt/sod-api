class User::RegistrationsController < Devise::RegistrationsController
	skip_before_filter :verify_authenticity_token, :only => :create
  prepend_before_filter :authenticate_scope!, only: [:edit, :destroy]

    def create
      user = User.new(sign_up_params)
      if (params[:user][:username].blank? || params[:user][:firstname].blank? || params[:user][:lastname].blank? || params[:user][:town].blank? || params[:user][:country].blank? || params[:user][:sex].blank? || params[:user][:birthday].blank?)
    	   render json: {error: "Please fill all the area."}, status: 422
      elsif user.save
        user.update(created_at: DateTime.now)
        render json: {success: "Your account has been created."}, status: 201
      else
        warden.custom_failure!
        render json: { error: user.errors }, status: 422
      end
    end

    def update
      user = User.where(authentication_token: params[:token]).first
      if user.nil? || !user.valid_password?(params[:user][:current_password])
        render json: {error: "The current_password is incorrect"}, status: 422
      elsif user.update(update_params)
        user.update(updated_at: DateTime.now)
        render json: {success: "Your account has been updated."}, status: 200
      else
        warden.custom_failure!
        render json: { error: user.errors }, status: 422
      end
    end

    private
      def sign_up_params
        params.require(:user).permit(:firstname, :lastname, :username, :town, :country, :sex, :birthday, :email, :password, :password_confirmation)
      end

      def update_params
        params.require(:user).permit(:email, :password, :password_confirmation, :username)
      end
end