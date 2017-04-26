# encoding: utf-8
# frozen_string_literal: true

FactoryGirl.define do
  factory(:housing_duration) do
    name { FFaker::LoremFR.word }
  end
end
