class CreateReceipts < ActiveRecord::Migration
  def change
    create_table :receipts do |t|
      t.references :user, index: true, foreign_key: true, null: false
      t.string :token, default: "", null: false
      t.string :data, default: "", null: false

      t.timestamps null: false
    end
  end
end
