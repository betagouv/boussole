class RemoveOperatorFromCriteria < ActiveRecord::Migration
  def change
    remove_column :criteria, :operator, :string
  end
end
