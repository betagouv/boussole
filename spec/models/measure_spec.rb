# encoding: utf-8
# frozen_string_literal: true

RSpec.describe Measure, type: :model do
  let(:measure)      { create(:measure) }
  let(:social_right) { create(:social_right) }

  it { is_expected.to belong_to(:public_service) }

  it { is_expected.to validate_presence_of(:title) }
  it { is_expected.to validate_presence_of(:url) }

  it 'has_many :social_rights' do
    expect {
      measure.social_rights << social_right
    }.to change { measure.social_rights.count }.by(1)
  end

  it 'delegates :title to :public_service' do
    expect(measure.public_service_title).to be_nil
  end
end
