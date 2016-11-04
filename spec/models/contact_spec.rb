# encoding: utf-8
# frozen_string_literal: true

RSpec.describe Contact, type: :model do
  it { is_expected.to validate_presence_of(:email_or_phone) }
end
