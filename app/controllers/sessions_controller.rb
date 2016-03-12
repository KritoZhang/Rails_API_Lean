class SessionsController < ApplicationController
  respond_to :json

  def create
    password = params[:session][:password]
    email = params[:session][:email]
    user = email.present? && User.find_by(email: email)
    if user and user.valid_password? password
      #sign_in user
      user.generate_authentication_token!
      user.save
      render json: user, status: 200
    else
      render json: { errors: "Invalid email or password" }, status: 422
    end
  end

  def destroy
    user = User.find_by(auth_token: params[:id])
    user.generate_authentication_token!
    user.save
    head 204
  end
end
