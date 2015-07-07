class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.float :lat
      t.float :long
      t.integer :difficulty
      t.integer :attempts
      t.integer :correct

      t.timestamps null: false
    end
  end
end
