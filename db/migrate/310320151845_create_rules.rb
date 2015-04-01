class CreateRules < ActiveRecord::Migration
  def change
    create_table :rules, force: true do |t|
      t.text :rules
      t.timestamps
    end
  end
end