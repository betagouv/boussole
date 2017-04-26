class CreateMissionLocales < ActiveRecord::Migration
  def change
    create_table :mission_locales do |t|
      t.boolean :value, index: { unique: true }, null: false

      t.timestamps null: false
    end

    create_table :target_public_mission_locales do |t|
      t.references :target_public, index: true, foreign_key: true, null: false
      t.references :mission_locale, index: true, foreign_key: true, null: false

      t.timestamps null: false
    end
  end
end
