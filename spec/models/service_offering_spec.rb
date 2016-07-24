# encoding: utf-8
# frozen_string_literal: true

RSpec.describe ServiceOffering, type: :model do
  it { is_expected.to belong_to(:public_service) }

  it { is_expected.to validate_presence_of(:title) }
  it { is_expected.to validate_presence_of(:description) }
end
