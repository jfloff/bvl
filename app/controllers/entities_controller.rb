class EntitiesController < ApplicationController
  
  def show
    @entity = Entity.find(params[:id])
  end

  def new
  	@entity = Entity.new
  end

  def create
    @entity = Entity.new(params[:entity])
    if @entity.save
    	flash[:success] = "Bem-vindo ao Banco de Voluntariado de Lisboa!"
      redirect_to @entity
    else
      render 'new'
    end
  end
end