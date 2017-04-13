# encoding: utf-8
# frozen_string_literal: true

RSpec.describe SocialRight, type: :model do
  subject                { create(:social_right) }
  let(:public_service)   { create(:public_service) }
  let(:service_offering) { create(:service_offering) }
  let(:measure)          { create(:measure) }

  it { is_expected.to have_many(:service_offerings) }

  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_uniqueness_of(:name) }

  it 'has_many :public_services' do
    expect {
      subject.public_services << public_service
    }.to change { subject.public_services.count }.by(1)
  end

  it 'has_many :measures' do
    expect {
      subject.measures << measure
    }.to change { subject.measures.count }.by(1)
  end
end
