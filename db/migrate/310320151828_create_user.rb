class CreateUser < ActiveRecord::Migration
  def change
    create_table :users, force: true do |t|
      t.string :name
      t.datetime :lastseen
      t.string :lastas
      t.datetime :sawrules
      t.timestamps
    end
  end
end