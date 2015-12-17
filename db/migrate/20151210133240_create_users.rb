class CreateUsers < ActiveRecord::Migration
  def up
    create_table :users, force: true do |table|
      table.string :email, null: false
      table.timestamps null: true
    end
  end

  def down
    drop_table :users
  end
end
