class SessionsController < ApplicationController
  respond_to :json

  def create
    password = params[:session][:password]
    email = params[:session][:email]
    user = email.present? && User.find_by(email: email)
    if user.valid_password? password
      #sign_in user, store: false
      user.generate_authentication_token!
      user.save
      render json: user, status: 200
    else
      render json: { errors: "Invalid email or password" }, status: 422
    end
  end

  def destroy
  end
end
# 13355811922
