class AddPasswordDigestToEntities < ActiveRecord::Migration
  def change
    add_column :entities, :password_digest, :string
  end
end
