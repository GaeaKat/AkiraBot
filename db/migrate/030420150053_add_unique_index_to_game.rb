class AddUniqueIndexToGame < ActiveRecord::Migration
  def change
    add_index :games, [:name], :unique=>true
  end
end