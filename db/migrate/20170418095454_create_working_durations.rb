class CreateWorkingDurations < ActiveRecord::Migration
  def change
    create_table :working_durations do |t|
      t.string :name, index: { unique: true }, null: false

      t.timestamps null: false
    end

    create_table :target_public_working_durations do |t|
      t.references :target_public, index: true, foreign_key: true, null: false
      t.references :working_duration, index: true, foreign_key: true, null: false

      t.timestamps null: false
    end
  end
end
