class CreateGames < ActiveRecord::Migration
  def change
    create_table :games do |t|
      t.references :user, index: true, foreign_key: true
      t.integer :score
      t.integer :progress
      t.boolean :completed

      t.timestamps null: false
    end
  end
end
