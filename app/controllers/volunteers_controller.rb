class VolunteersController < ApplicationController
  
  def show
    @volunteer = Volunteer.find(params[:id])
  end

  def new
    @volunteer = Volunteer.new
  end

  def create
    @volunteer = Volunteer.new(params[:volunteer])
    if @volunteer.save
    	flash[:success] = "Bem-vindo ao Banco de Voluntariado de Lisboa!"
      redirect_to @volunteer
    else
      render 'new'
    end
  end
end
