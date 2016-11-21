# encoding: utf-8
# frozen_string_literal: true

RSpec.describe HousingsController, type: :controller do
  let(:housing)       { create(:housing) }
  let(:event_tracker) { instance_spy(EventTracker) }

  before do
    allow(Flip).to receive(:on?) { true }
    allow(subject).to receive(:tracker) { event_tracker }
  end

  it 'GET #show' do
    get(:show, id: housing.to_param)
    expect(event_tracker).to have_received(:call).with(:jeunes, :finishes_form, duck_type(:each_pair))
  end

  it 'POST #create' do
    post(:create)
    expect(event_tracker).to have_received(:call).with(:jeunes, :starts_form, duck_type(:each_pair))
  end
end
