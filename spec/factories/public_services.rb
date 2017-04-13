# encoding: utf-8
# frozen_string_literal: true

FactoryGirl.define do
  factory(:public_service) do
    title                     { FFaker::LoremFR.word }
    email                     { FFaker::Internet.email }
    response_time_upper_bound 7
  end
end
