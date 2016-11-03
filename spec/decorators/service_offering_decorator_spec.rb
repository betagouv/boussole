# encoding: utf-8
# frozen_string_literal: true

RSpec.describe ServiceOfferingDecorator, type: :decorator do
  subject(:decorator)        { described_class.(service_offering) }
  let(:service_offering)     { build(:service_offering, public_service: public_service) }
  let(:public_service)       { build(:public_service) }

  describe '#email' do
    context '#public_service with #email' do
      before do
        public_service.update(email: 'jean@seri.en')
        service_offering.update(email: nil)
      end

      it { expect(decorator.email).to eq('jean@seri.en') }
    end

    context '#public_service without #email' do
      before do
        public_service.update(email: nil)
        service_offering.update(email: 'jean@seri.en')
      end

      it { expect(decorator.email).to eq('jean@seri.en') }
    end
  end

  describe '#response_time_upper_bound' do
    context '#public_service with #response_time_upper_bound' do
      before do
        public_service.update(response_time_upper_bound: 7)
        service_offering.update(response_time_upper_bound: nil)
      end

      it { expect(decorator.response_time_upper_bound).to eq(7) }
    end

    context '#public_service without #response_time_upper_bound' do
      before do
        public_service.update(response_time_upper_bound: nil)
        service_offering.update(response_time_upper_bound: 7)
      end

      it { expect(decorator.response_time_upper_bound).to eq(7) }
    end
  end
end
