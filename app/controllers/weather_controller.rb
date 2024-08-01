# frozen_string_literal: true

class WeatherController < ApplicationController
  def index
    api_key = '79c8c7a115f831601ccb9b01ba0aa13f'
    @challenge = Challenge.find_by(user_token: params[:user_token])
    @challenge = Challenge.create(user_token: SecureRandom.uuid) if @challenge.nil? || @challenge.create_at < 1.day.ago
    api = WeatherApi.new(api_key, @challenge.id)
    api.weather_by_city('New York')

    @weather = @challenge.reload.weekly_weather_forecast
  end

  def update
    challenge = Challenge.find_by(id: params[:challenge_id])
    return head :not_found if challenge.nil?

    selected_temperature = params[:temperature]
    # Process the selected temperature as needed

    if selected_temperature != challenge.challenge_answer.to_i - 273.15
      return redirect_to weather_path, alert: "You selected #{selected_temperature}°F. That's incorrect! Correct answer is #{challenge.challenge_answer.to_i - 273.15}°F."
    end

    redirect_to weather_path, notice: "You selected #{selected_temperature}°F. Thats correct!"
  end
end
