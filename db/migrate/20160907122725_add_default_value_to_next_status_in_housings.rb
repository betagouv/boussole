class AddDefaultValueToNextStatusInHousings < ActiveRecord::Migration
  def change
    change_column_default(:housings, :next_status, false)
  end
end
