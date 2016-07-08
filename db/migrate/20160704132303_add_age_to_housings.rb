class AddAgeToHousings < ActiveRecord::Migration
  def change
    add_column :housings, :age, :integer
  end
end
