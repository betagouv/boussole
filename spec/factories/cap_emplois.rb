# encoding: utf-8
# frozen_string_literal: true

FactoryGirl.define do
  factory(:cap_emploi) do
    value { rand(2).zero? }
  end
end
