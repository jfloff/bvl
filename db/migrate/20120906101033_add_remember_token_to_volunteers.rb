class AddRememberTokenToVolunteers < ActiveRecord::Migration
  def change
  	add_column :volunteers, :remember_token, :string
    add_index  :volunteers, :remember_token
  end
end
