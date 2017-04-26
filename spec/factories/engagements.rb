# encoding: utf-8
# frozen_string_literal: true

FactoryGirl.define do
  factory(:engagement) do
    name { FFaker::LoremFR.word }
  end
end
