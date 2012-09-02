class AddIndexToVolunteersEmailAndUsername < ActiveRecord::Migration
  def change
  	add_index :volunteers, :email, unique: true
  	add_index :volunteers, :username, unique: true
  end
end
