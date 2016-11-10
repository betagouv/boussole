# encoding: utf-8
# frozen_string_literal: true

RSpec.describe Working::ServiceOfferings, type: :operation do
  subject(:operation)    { described_class.present(id: working.to_param) }
  let(:public_service)   { create(:public_service, title: 'APEC') }

  let(:service_offering) do
    create(
      :service_offering,
      title: 'Améliorer mon CV',
      public_service: public_service
    )
  end

  let(:working) do
    create(
      :working,
      last_class: 'Études supérieures',
      status: 'Sans activité',
      age: 22
    )
  end

  before { stub_const("#{described_class}::CRITERIAS_PATH", -> { 'spec/fixtures/criterias/working.service_offerings.yml' }) }

  context 'with matches' do
    it { expect(operation.scope).to include(service_offering) }
  end

  context 'without matches' do
    before { working.update_attributes(age: 21) }

    it { expect(operation.scope).not_to include(service_offering) }
  end
end
