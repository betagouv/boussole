class CreatePoleEmplois < ActiveRecord::Migration
  def change
    create_table :pole_emplois do |t|
      t.boolean :value, index: { unique: true }, null: false

      t.timestamps null: false
    end

    create_table :target_public_pole_emplois do |t|
      t.references :target_public, index: true, foreign_key: true, null: false
      t.references :pole_emploi, index: true, foreign_key: true, null: false

      t.timestamps null: false
    end
  end
end
