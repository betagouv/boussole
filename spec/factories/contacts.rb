# encoding: utf-8
# frozen_string_literal: true

FactoryGirl.define do
  factory(:contact) do
    email_or_phone FFaker::Internet.email
  end
end
