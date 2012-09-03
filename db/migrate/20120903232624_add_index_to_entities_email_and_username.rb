class AddIndexToEntitiesEmailAndUsername < ActiveRecord::Migration
  def change
  	add_index :entities, :email, unique: true
  	add_index :entities, :username, unique: true
  end
end
