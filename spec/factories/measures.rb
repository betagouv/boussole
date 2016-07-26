# encoding: utf-8
# frozen_string_literal: true

FactoryGirl.define do
  factory(:measure) do
    title FFaker::LoremFR.word
    url FFaker::Internet.http_url
  end
end
