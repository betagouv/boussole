class CreateHousingStatuses < ActiveRecord::Migration
  def change
    create_table :housing_statuses do |t|
      t.string :name, index: { unique: true }, null: false

      t.timestamps null: false
    end

    create_table :target_public_housing_statuses do |t|
      t.references :target_public, index: true, foreign_key: true, null: false
      t.references :housing_status, index: true, foreign_key: true, null: false

      t.timestamps null: false
    end
  end
end
