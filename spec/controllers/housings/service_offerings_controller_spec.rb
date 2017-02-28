# encoding: utf-8
# frozen_string_literal: true

RSpec.describe Housings::ServiceOfferingsController, type: :controller do
  let(:housing)          { create(:housing) }
  let(:service_offering) { create(:service_offering, public_service: create(:public_service)) }
  let(:event_tracker)    { instance_spy(EventTracker) }

  before { allow(subject).to receive(:tracker) { event_tracker } }

  it 'GET #show' do
    get(:show, id: service_offering.to_param, housing_id: housing.to_param)
    expect(event_tracker).to have_received(:call).with(:jeunes, :discovers_service, duck_type(:each_pair))
  end
end
