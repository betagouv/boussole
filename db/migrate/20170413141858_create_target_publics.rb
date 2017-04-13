class CreateTargetPublics < ActiveRecord::Migration
  def change
    create_table :target_publics do |t|

      t.timestamps null: false
    end
  end
end
