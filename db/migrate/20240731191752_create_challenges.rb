class CreateChallenges < ActiveRecord::Migration[7.1]
  def change
    create_table :challenges do |t|
      t.string :user_token
      t.json :weekly_weather_forecast

      t.timestamps
    end
  end
end
