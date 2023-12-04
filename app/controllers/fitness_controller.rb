class FitnessController < ApplicationController

  def index
    @fitness = Fitness.all 
  end

  def show
    @fitness = Fitness.find(params[:id])
  end

  def create
    @fitness = Fitness.new(title: "...", body: "...")

    if @fitness.save
      redirect_to @fitness
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @fitness = Fitness.find(params[:id])
  end

  def update
    @fitness = Fitness.find(params[:id])

    if @fitness.update(fitness_params)
      redirect_to @fitness
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @fitness = Fitness.find(params[:id])
    @fitness.destroy

    redirect_to root_path, status: :see_other
  end

  
  private
    def fitness_params
      params.require(:fitness).permit(:title, :body, :status)
    end


end
