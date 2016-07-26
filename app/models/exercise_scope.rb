# encoding: utf-8
# frozen_string_literal: true
#
# TODO: Add documentation.
#
# == Schema Information
#
# Table name: exercise_scopes
#
#  id               :integer          not null, primary key
#  social_right_id  :integer          not null
#  exercisable_id   :integer          not null
#  exercisable_type :string           not null
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#
# Indexes
#
#  index_exercise_scopes_on_exercisable_type_and_exercisable_id  (exercisable_type,exercisable_id)
#  index_exercise_scopes_on_social_right_id                      (social_right_id)
#
# Foreign Keys
#
#  fk_rails_7ab7a484c8  (social_right_id => social_rights.id)
#
class ExerciseScope < ApplicationRecord
  belongs_to :social_right
  belongs_to :exercisable, polymorphic: true, inverse_of: :exercise_scopes
end
