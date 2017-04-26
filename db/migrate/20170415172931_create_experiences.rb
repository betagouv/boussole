class CreateExperiences < ActiveRecord::Migration
  def change
    create_table :experiences do |t|
      t.boolean :value, index: { unique: true }, null: false

      t.timestamps null: false
    end

    create_table :target_public_experiences do |t|
      t.references :target_public, index: true, foreign_key: true, null: false
      t.references :experience, index: true, foreign_key: true, null: false

      t.timestamps null: false
    end
  end
end
