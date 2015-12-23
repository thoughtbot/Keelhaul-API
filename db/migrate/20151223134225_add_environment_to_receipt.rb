class AddEnvironmentToReceipt < ActiveRecord::Migration
  def change
    add_column :receipts, :environment, :integer, default: 0, null: false
  end
end
