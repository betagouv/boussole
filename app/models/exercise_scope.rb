# encoding: utf-8
# frozen_string_literal: true

#
# Class ExerciseScope provides a polymorphic proxy to relate {SocialRight}s to
# excercisable models like {PublicService}s, {ServiceOffering}s and {Measure}s.
#
# @author Mauko Quiroga <mauko.quiroga@data.gouv.fr>
#
class ExerciseScope < ApplicationRecord
  belongs_to :social_right
  belongs_to :exercisable, polymorphic: true, inverse_of: :exercise_scopes
end
