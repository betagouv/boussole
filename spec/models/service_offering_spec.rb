# encoding: utf-8
# frozen_string_literal: true

RSpec.describe ServiceOffering, type: :model do
  subject(:service_offering) { create(:service_offering, public_service: public_service) }
  let(:public_service)       { create(:public_service) }
  let(:social_right)         { create(:social_right) }

  it { is_expected.to belong_to(:public_service) }

  it { is_expected.to validate_presence_of(:title) }
  it { is_expected.to validate_uniqueness_of(:slug) }
  it { is_expected.to validate_presence_of(:public_service) }

  it 'has_many :social_rights' do
    expect {
      service_offering.social_rights << social_right
    }.to change { service_offering.social_rights.count }.by(1)
  end
end
