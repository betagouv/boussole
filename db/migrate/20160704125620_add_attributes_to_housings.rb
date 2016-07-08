class AddAttributesToHousings < ActiveRecord::Migration
  def change
    add_column :housings, :duration, :string
    add_column :housings, :status, :string
    add_column :housings, :resources, :integer
  end
end
