class RemoveNameFromCriteria < ActiveRecord::Migration
  def change
    remove_column :criteria, :name, :string
  end
end
