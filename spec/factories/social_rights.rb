# encoding: utf-8
# frozen_string_literal: true

FactoryGirl.define do
  factory(:social_right) do
    name { FFaker::LoremFR.word }

    trait(:working) { name('Emploi') }
    trait(:housing) { name('Logement') }
  end
end
