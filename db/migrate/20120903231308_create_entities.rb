class CreateEntities < ActiveRecord::Migration
  def change
    create_table :entities do |t|
      t.string :username
      t.string :name
      t.string :email

      t.timestamps
    end
  end
end
