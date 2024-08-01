class CreateChallengeAnswer < ActiveRecord::Migration[7.1]
  def change
    add_column :challenges, :challenge_answer, :string
  end
end
