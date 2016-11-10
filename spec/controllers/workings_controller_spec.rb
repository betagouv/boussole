# encoding: utf-8
# frozen_string_literal: true

RSpec.describe WorkingsController, type: :controller do
  let(:working)       { create(:working) }
  let(:event_tracker) { instance_spy(EventTracker) }

  before do
    allow(subject).to receive(:tracker) { event_tracker }
    allow(ENV).to receive(:[]).with('RHIZOME') { 'reims' }
  end

  it 'GET #show' do
    get(:show, id: working.to_param)
    expect(event_tracker).to have_received(:call).with(:jeunes, :finishes_form, duck_type(:each_pair))
  end

  it 'POST #create' do
    post(:create)
    expect(event_tracker).to have_received(:call).with(:jeunes, :starts_form, duck_type(:each_pair))
  end
end
