class CreateJoinTableTargetPublicsStatuses < ActiveRecord::Migration
  def change
    create_join_table :target_publics, :statuses do |t|
      t.index :target_public_id
      t.index :status_id
    end
  end
end
