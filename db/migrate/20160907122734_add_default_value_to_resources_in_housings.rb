class AddDefaultValueToResourcesInHousings < ActiveRecord::Migration
  def change
    change_column_default(:housings, :resources, 0)
  end
end
