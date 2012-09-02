class CreateVolunteers < ActiveRecord::Migration
  def change
    create_table :volunteers do |t|
      t.string :username
      t.string :name
      t.string :email

      t.timestamps
    end
  end
end
