class CreateLastClasses < ActiveRecord::Migration
  def change
    create_table :last_classes do |t|
      t.string :name, index: { unique: true }, null: false

      t.timestamps null: false
    end

    create_table :target_public_last_classes do |t|
      t.references :target_public, index: true, foreign_key: true, null: false
      t.references :last_class, index: true, foreign_key: true, null: false

      t.timestamps null: false
    end
  end
end
