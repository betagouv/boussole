# encoding: utf-8
# frozen_string_literal: true

RSpec::Matchers.define :be_a_kind_of_slug do
  match do |actual|
    actual =~ /\A[a-z0-9\-]+\z/
  end
end
