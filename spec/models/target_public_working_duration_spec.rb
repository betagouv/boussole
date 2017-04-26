# encoding: utf-8
# frozen_string_literal: true

RSpec.describe TargetPublicWorkingDuration, type: :model do
  it_should_behave_like :targetable, :working_duration
end
