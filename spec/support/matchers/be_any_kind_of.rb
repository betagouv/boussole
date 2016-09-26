# encoding: utf-8
# frozen_string_literal: true

RSpec::Matchers.define :be_any_kind_of do |*array|
  match do |actual|
    array.inject(false) do |result, klass|
      result || actual.is_a?(klass)
    end
  end
end
