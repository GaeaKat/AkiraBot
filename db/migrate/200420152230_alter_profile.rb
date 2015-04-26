class AlterProfile < ActiveRecord::Migration
  def change
    add_index :profiles , [:user_id] , :unique => true
  end
end