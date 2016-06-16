class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.string :knowledge
      t.string :profession
      t.integer :age
      t.string :status
      t.string :last_class
      t.string :city
      t.boolean :handicap
      t.boolean :experience
      t.boolean :pe
      t.boolean :ml
      t.boolean :cap
      t.boolean :apec
      t.string :area

      t.timestamps null: false
    end
  end
end
