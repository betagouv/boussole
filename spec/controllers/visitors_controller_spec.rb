# encoding: utf-8
# frozen_string_literal: true

RSpec.describe VisitorsController, type: :controller do
  let(:event_tracker) { instance_spy(EventTracker) }

  before { allow(subject).to receive(:tracker) { event_tracker } }

  describe 'GET #index' do
    before do
      request.env['HTTP_USER_AGENT'] = user_agent
      get(:index)
    end

    context 'with uptime calls' do
      let(:user_agent) { 'UptimeRobot' }

      it { expect(response).to have_http_status(:ok) }
      it { expect(response).not_to render_template(:index) }
      it { expect(event_tracker).not_to have_received(:call) }
    end

    context 'without uptime calls' do
      let(:user_agent) { 'DowntimeRobot' }

      it { expect(response).to have_http_status(:ok) }
      it { expect(response).to render_template(:index) }
      it { expect(event_tracker).to have_received(:call).with(:jeunes, :visits_landing) }
    end
  end
end
