class CreateTargetPublics < ActiveRecord::Migration
  def change
    create_table :target_publics do |t|
      t.references :service_offering, index: true, foreign_key: true, null: false

      t.timestamps null: false
    end
  end
end
