class AddCitiesToHousings < ActiveRecord::Migration
  def change
    add_column :housings, :housing_city, :string
    add_column :housings, :residence_city, :string
  end
end
