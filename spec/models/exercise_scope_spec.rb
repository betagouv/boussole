# encoding: utf-8
# frozen_string_literal: true

RSpec.describe ExerciseScope, type: :model do
  it { is_expected.to belong_to(:social_right) }
  it { is_expected.to belong_to(:exercisable) }
end
