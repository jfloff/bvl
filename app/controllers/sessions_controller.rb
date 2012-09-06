#encoding: utf-8

class SessionsController < ApplicationController

	def new
  end

  def create
    volunteer = Volunteer.find_by_email(params[:session][:email].downcase)
    if volunteer && volunteer.authenticate(params[:session][:password])
      sign_in volunteer
      redirect_to volunteer
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
