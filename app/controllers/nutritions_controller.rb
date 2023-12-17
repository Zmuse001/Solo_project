class NutritionsController < ApplicationController

  def index
    @nutrition = Nutrition.all
  end

  def show
    @nutrition = Nutrition.find(params[:id])
  end

  def new
    @nutrition = Nutrition.new
  end

  def create
    response = make_api_request(params[:nutrition][:user_input])
    fitness_data = extract_data_from_api_response(response)

    fitness_data.each do |data|
      @nutrition = current_user.nutritions.build(
        serving_units: data['serving_unit'],
        serving_weight_grams: data['serving_weight_grams'],
        food_name: data['food_name'],
        calories: data['nf_calories'],
        protein: data['nf_protein'],
        total_fat: data['nf_total_fat'],
        total_carbohydrates: data['nf_total_carbohydrate'],
        sugar: data['nf_sugars']
        # Add other attributes as needed
      )

      # Save each nutrition entry inside the loop
      unless @nutrition.save
        puts "Error saving nutrition entry: #{@nutrition.errors.full_messages.join(', ')}"
        render :new and return
      end
    end

    puts "All nutrition entries saved successfully!"
    redirect_to nutritions_path, notice: 'Nutritions entries logged successfully.'
  end

  def edit
    @nutrition = Nutrition.find(params[:id])
  end

  def update
    @nutrition = Nutrition.find(params[:id])

    if @nutrition.update(nutrition_params)
      redirect_to @nutrition
    else
      render :edit, :unprocessable_entity
    end
  end 

  def destroy
    @nutrition = Nutrition.find(params[:id])
    @nutrition.destroy

    redirect_to root_path, status: :see_other
  end

  private
    
    def make_api_request(input)
      url = 'https://trackapi.nutritionix.com/v2/natural/nutrients'
      headers = {
        'Content-Type': 'application/json',
        'x-app-id': '3b10b065',
        'x-app-key': '2c3c4bf48541fceb8358b9637625bf12'
      }
      payload = {
        query: input
      }
      response = RestClient.post(url, payload.to_json, headers)
      JSON.parse(response.body)
    end
  
    def extract_data_from_api_response(response)
      response['foods']
    end
  
    def nutrition_params
      params.require(:nutrition).permit(:food_name, :serving_units, :serving_weight_grams, :protein, :calories, :total_carbohydrates, :total_fat, :sugar)
    end

  end 