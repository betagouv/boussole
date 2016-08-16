class CreateExerciseScopes < ActiveRecord::Migration
  def change
    create_table :exercise_scopes do |t|
      t.references :social_right, index: true, foreign_key: true, null: false
      t.references :exercisable, polymorphic: true, index: true, null: false

      t.timestamps null: false
    end
  end
end
