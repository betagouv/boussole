# encoding: utf-8
# frozen_string_literal: true

RSpec::Matchers.define :be_included_in_delimiter_for do |klass, attribute|
  match do |actual|
    delimiter =
      klass
      .validators
      .select { |validator| validator.attributes.include?(attribute.to_sym) }
      .select { |validator| validator.kind == :inclusion }
      .first
      .send(:try, :delimiter)

    return true unless delimiter

    Array.wrap(actual).to_set.subset?(delimiter.to_set)
  end
end
