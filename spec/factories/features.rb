# encoding: utf-8
# frozen_string_literal: true

FactoryGirl.define do
  factory(:feature) do
    enabled true

    trait(:working) { key('working') }
  end
end
