class CreateJoinTableCriteriaStatuses < ActiveRecord::Migration
  def change
    create_join_table :criteria, :statuses do |t|
      t.index :criterium_id
      t.index :status_id
    end
  end
end
