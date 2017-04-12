class RemoveValueFromCriteria < ActiveRecord::Migration
  def change
    remove_column :criteria, :value, :string
  end
end
