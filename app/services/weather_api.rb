require 'httparty'

class WeatherApi
  include HTTParty
  base_uri 'https://api.openweathermap.org/data/2.5'

  def initialize(api_key, challenge_id)
    @challenge_id = challenge_id
    @api_key = api_key
  end

  def weather_by_city(city)
    date_range = Array.new(7) {|i| [Date.today + i.days] }
    challenge.weekly_weather_forecast = {}

    date_range.each do |date|
      options = { query: { date: date.join(' '), appid: @api_key } }
      weather = self.class.get("/weather?q=#{city}", options)

      challenge.weekly_weather_forecast[date.join] = weather
      challenge.save
    end

    challenge.challenge_answer = challenge.weekly_weather_forecast.values.sample['main']['temp']
    challenge.save
  end

  def challenge
    @challenge ||= Challenge.find(@challenge_id)
  end
end
