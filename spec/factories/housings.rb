# encoding: utf-8
# frozen_string_literal: true

FactoryGirl.define do
  factory(:housing) do
    duration  FFaker::LoremFR.word
    status    FFaker::JobFR.title
    resources { rand(0..10_000) }
    age       { rand(0..123) }

    trait(:housing) { current_step(:housing) }
    trait(:profile) { current_step(:profile) }
  end
end
