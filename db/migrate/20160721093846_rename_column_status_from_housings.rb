class RenameColumnStatusFromHousings < ActiveRecord::Migration
  def change
    rename_column :housings, :status, :current_status
  end
end
