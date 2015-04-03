class CreateGame < ActiveRecord::Migration
  def change
    create_table :games, force: true do |t|
      t.string :name
      t.text :rules
      t.timestamps
    end
  end
end