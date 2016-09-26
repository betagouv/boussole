# encoding: utf-8
# frozen_string_literal: true

FactoryGirl.define do
  factory(:working) do
    trait(:awareness)    { current_step(:awareness) }
    trait(:project)      { current_step(:project) }
    trait(:situation)    { current_step(:situation) }
    trait(:inscriptions) { current_step(:inscriptions) }
  end
end
