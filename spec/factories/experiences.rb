# encoding: utf-8
# frozen_string_literal: true

FactoryGirl.define do
  factory(:experience) do
    value { rand(2).zero? }
  end
end
