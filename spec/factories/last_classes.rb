# encoding: utf-8
# frozen_string_literal: true

FactoryGirl.define do
  factory(:last_class) do
    name { FFaker::LoremFR.word }
  end
end
