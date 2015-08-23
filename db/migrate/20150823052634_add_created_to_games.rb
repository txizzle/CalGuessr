class AddCreatedToGames < ActiveRecord::Migration
  def change
    add_column :games, :created, :DateTime
  end
end
