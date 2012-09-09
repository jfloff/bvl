class AddRememberTokenToEntities < ActiveRecord::Migration
  def change
  	add_column :entities, :remember_token, :string
    add_index  :entities, :remember_token
  end
end
