# encoding: utf-8
# frozen_string_literal: true

#
# TODO: Add documentation.
#

#
# == Schema Information
# Schema version: 20160914121308
#
# Table name: exercise_scopes
#
# *id*::               <tt>integer, not null, primary key</tt>
# *social_right_id*::  <tt>integer, not null</tt>
# *exercisable_id*::   <tt>integer, not null</tt>
# *exercisable_type*:: <tt>string, not null</tt>
# *created_at*::       <tt>datetime, not null</tt>
# *updated_at*::       <tt>datetime, not null</tt>
#
# Indexes
#
#  index_exercise_scopes_on_exercisable_type_and_exercisable_id  (exercisable_type,exercisable_id)
#  index_exercise_scopes_on_social_right_id                      (social_right_id)
#
# Foreign Keys
#
#  fk_rails_7ab7a484c8  (social_right_id => social_rights.id)
#--
# == Schema Information End
#++
#
class ExerciseScope < ApplicationRecord
  belongs_to :social_right
  belongs_to :exercisable, polymorphic: true, inverse_of: :exercise_scopes
end
