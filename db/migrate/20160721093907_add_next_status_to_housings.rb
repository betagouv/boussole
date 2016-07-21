class AddNextStatusToHousings < ActiveRecord::Migration
  def change
    add_column :housings, :next_status, :boolean
  end
end
