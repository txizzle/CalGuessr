class RenameCorrectToRating < ActiveRecord::Migration
  def change
    rename_column :questions, :correct, :rating
  end
end
