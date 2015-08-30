class RemoveDifficultyFromGames < ActiveRecord::Migration
  def change
    remove_column :games, :difficulty, :integer
  end
end
