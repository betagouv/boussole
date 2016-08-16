# encoding: utf-8
# frozen_string_literal: true

RSpec.describe PublicService, type: :model do
  let(:public_service) { create(:public_service) }
  let(:social_right)   { create(:social_right) }

  it { is_expected.to have_many(:service_offerings) }
  it { is_expected.to have_many(:measures) }

  it { is_expected.to validate_presence_of(:title) }

  it 'has_many :social_rights' do
    expect {
      public_service.social_rights << social_right
    }.to change { public_service.social_rights.count }.by(1)
  end
end
