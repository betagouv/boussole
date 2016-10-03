# encoding: utf-8
# frozen_string_literal: true

RSpec::Matchers.define :be_included_in do |array|
  match do |actual|
    Array.wrap(actual).to_set.subset?(array.to_set)
  end
end
