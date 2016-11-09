# encoding: utf-8
# frozen_string_literal: true

RSpec.describe VisitorsController, type: :controller do
  let(:event_tracker) { instance_spy(EventTracker) }

  before { allow(subject).to receive(:tracker) { event_tracker } }

  it 'GET #index' do
    get(:index)
    expect(event_tracker).to have_received(:call).with(:jeunes, :visits_landing)
  end
end
