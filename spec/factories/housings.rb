# encoding: utf-8
# frozen_string_literal: true

FactoryGirl.define do
  factory(:housing) do
    trait(:housing) { current_step(:housing) }
    trait(:profile) { current_step(:profile) }
  end
end
