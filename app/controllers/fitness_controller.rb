class FitnessController < ApplicationController
  before_action :set_fitness, only: [:show, :edit, :destroy]

  def index
    @fitness = Fitness.all
  end

  def show
    @fitness = Fitness.find(params[:id])
  end

  def new
    @fitness = Fitness.new
  end

  def create
    response = make_api_request(params[:fitness][:user_input])
    fitness_data = extract_data_from_api_response(response)

    fitness_data.each do |data|
      @fitness = current_user.fitness.build(
        user_input: params[:fitness][:user_input],
        duration: data['duration_min'],
        calories_burned: data['nf_calories'],
        met: data['met']
        # Add other attributes as needed
      )

      # Save each fitness entry inside the loop
      unless @fitness.save
        puts "Error saving fitness entry: #{@fitness.errors.full_messages.join(', ')}"
        render :new and return
      end
    end

    puts "All fitness entries saved successfully!"
    redirect_to fitness_index_path, notice: 'Fitness entries logged successfully.'
  end

  def update
    @fitness = Fitness.find(params[:id])

    if @fitness.update(fitness_params)
      redirect_to @fitness
    else
      render :edit, status: :unprocessable_entity
    end
  end  

  def edit
    @fitness = Fitness.find(params[:id])
  end

  def destroy
    @fitness.destroy
    # In your destroy action
    render turbo_stream: [
      turbo_stream.remove("fitness_show_frame")
    ]

    
    redirect_to fitness_path, notice: "fitness was successfully deleted"
  end

  private

  def set_fitness
    @fitness = Fitness.find(params[:id])
  end

  def make_api_request(input)
    url = 'https://trackapi.nutritionix.com/v2/natural/exercise'
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
    response['exercises']
  end

  def fitness_params
    params.require(:fitness).permit(:user_input, :duration, :calories_burned, :met)
  end

end