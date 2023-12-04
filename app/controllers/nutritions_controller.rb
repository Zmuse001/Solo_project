class NutritionsController < ApplicationController

  def index
    @nutritions = Nutrition.all
  end

  def show
    @nutrition = Nutrition.find(params[:id])
  end

  def new
    @nutrition = Nutrition.new
  end

  def create
    @nutrition = Nutrition.new(title: "...", body: "...")

    if @nutrition.save
      redirect_to @nutrition
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @nutrition = Nutrition.find(params[:id])
  end

  def update
    @nutrition = Nutrition.find(params[:id])

    if @nutrition.update(article_params)
      redirect_to @nutrition
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @nutrition = Nutrition.find(params[:id])
    @nutrition.destroy

    redirect_to root_path, status: :see_other
  end

  private
    def nutrition_params
      params.require(:nutrition).permit(:title, :body)
    end
end

end
