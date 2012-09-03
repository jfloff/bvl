class VolunteersController < ApplicationController
  
  def show
    @volunteer = Volunteer.find(params[:id])
  end

  def new
  end

end
