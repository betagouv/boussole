# encoding: utf-8
# frozen_string_literal: true

FactoryGirl.define do
  factory(:service_offering) do
    title FFaker::LoremFR.word
  end
end
