class CreateWorkings < ActiveRecord::Migration
  def change
    create_table :workings do |t|
      t.string :awareness
      t.string :sector
      t.boolean :experience
      t.string :duration
      t.string :engagement
      t.string :status
      t.integer :age
      t.boolean :handicap
      t.string :last_class
      t.string :city
      t.boolean :pole_emploi
      t.boolean :mission_locale
      t.boolean :cap_emploi
      t.boolean :apec

      t.timestamps null: false
    end
  end
end
