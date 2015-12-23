class AddMetadataToReceipt < ActiveRecord::Migration
  def change
    add_column :receipts, :metadata, :jsonb, default: "{}", null: false
  end
end
