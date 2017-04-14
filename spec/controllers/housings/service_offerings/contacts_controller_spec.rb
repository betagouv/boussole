# encoding: utf-8
# frozen_string_literal: true

RSpec.describe Housings::ServiceOfferings::ContactsController, type: :controller do
  let(:housing)          { create(:housing) }
  let(:service_offering) { create(:service_offering) }
  let(:event_tracker)    { instance_spy(EventTracker) }

  before { allow(subject).to receive(:tracker) { event_tracker } }

  it 'POST #create' do
    post(:create, service_offering_id: service_offering.to_param, housing_id: housing.to_param)
    expect(event_tracker).to have_received(:call).with(:jeunes, :activates_service, duck_type(:each_pair))
  end
end
