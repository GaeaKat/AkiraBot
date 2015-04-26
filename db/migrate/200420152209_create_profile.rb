class CreateProfile < ActiveRecord::Migration
  def change
    create_table :profiles, force: true do |t|
      t.integer :user_id
      t.integer :age
      t.string :gender
      t.string :location
      t.string :position
      t.string :kinks
      t.string :limits
      t.string :description
      t.timestamps
    end
  end
end