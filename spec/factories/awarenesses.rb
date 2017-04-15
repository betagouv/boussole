# encoding: utf-8
# frozen_string_literal: true

FactoryGirl.define do
  factory(:awareness) do
    name { FFaker::LoremFR.word }
  end
end
