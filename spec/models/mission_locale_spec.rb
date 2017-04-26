# encoding: utf-8
# frozen_string_literal: true

RSpec.describe MissionLocale, type: :model do
  it_should_behave_like :having_many_through, :target_publics
  it_should_behave_like :read_only, :value
  it_should_behave_like :unique, :value, :boolean
end
