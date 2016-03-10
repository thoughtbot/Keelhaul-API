class RenameTokenColumn < ActiveRecord::Migration
  def change
    rename_column :receipts, :token, :device_hash
  end
end
