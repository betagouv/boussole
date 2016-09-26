# encoding: utf-8
# frozen_string_literal: true

RSpec.describe 'Flyer Routes', type: :routing do
  context 'valid routes' do
    it { expect(get: '/reims1A').to route_to(controller: 'visitors', action: 'index', flyer: 'reims1A') }
    it { expect(get: '/reims1B').to route_to(controller: 'visitors', action: 'index', flyer: 'reims1B') }
    it { expect(get: '/reims1C').to route_to(controller: 'visitors', action: 'index', flyer: 'reims1C') }
    it { expect(get: '/reims1D').to route_to(controller: 'visitors', action: 'index', flyer: 'reims1D') }
    it { expect(get: '/reims1E').to route_to(controller: 'visitors', action: 'index', flyer: 'reims1E') }
    it { expect(get: '/reims1F').to route_to(controller: 'visitors', action: 'index', flyer: 'reims1F') }
    it { expect(get: '/reims1G').to route_to(controller: 'visitors', action: 'index', flyer: 'reims1G') }
    it { expect(get: '/reims1H').to route_to(controller: 'visitors', action: 'index', flyer: 'reims1H') }
    it { expect(get: '/reims1J').to route_to(controller: 'visitors', action: 'index', flyer: 'reims1J') }
    it { expect(get: '/reims1K').to route_to(controller: 'visitors', action: 'index', flyer: 'reims1K') }
    it { expect(get: '/reims1L').to route_to(controller: 'visitors', action: 'index', flyer: 'reims1L') }
    it { expect(get: '/reims1N').to route_to(controller: 'visitors', action: 'index', flyer: 'reims1N') }
  end

  context 'invalid routes' do
    it { expect(get: '/reims').not_to be_routable }
    it { expect(get: '/reims1').not_to be_routable }
    it { expect(get: '/reims1I').not_to be_routable }
    it { expect(get: '/reims1M').not_to be_routable }
    it { expect(get: '/reims1AA').not_to be_routable }
    it { expect(get: '/reims2').not_to be_routable }
    it { expect(get: '/reims2A').not_to be_routable }
  end
end
