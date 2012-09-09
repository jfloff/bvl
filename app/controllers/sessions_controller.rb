#encoding: utf-8

class SessionsController < ApplicationController

	def new
  end

  def create
    email_username = params[:session][:email_username].downcase
    user = Volunteer.find_by_email(email_username)
    user ||= Volunteer.find_by_username(email_username)
    user ||= Entity.find_by_email(email_username)
    user ||= Entity.find_by_username(email_username)
    if user && user.authenticate(params[:session][:password])
      sign_in user
      redirect_to user
    else
      flash.now[:error] = 'Email/username ou password inválidos.'
      render 'new'
    end
  end

  def destroy
    sign_out
    redirect_to root_url
  end
  
end
