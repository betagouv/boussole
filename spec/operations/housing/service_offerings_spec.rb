# encoding: utf-8
# frozen_string_literal: true

RSpec.describe Housing::ServiceOfferings, type: :operation do
  subject(:operation)    { described_class.present(id: housing.to_param) }
  let(:public_service)   { create(:public_service, title: 'Lokaviz') }

  let(:service_offering) do
    create(
      :service_offering,
      title: 'Trouver un coloc',
      public_service: public_service
    )
  end

  let(:housing) do
    create(
      :housing,
      duration: '1 an',
      housing_city: 'Reims',
      current_status: 'Étudiant·e',
      resources: 150
    )
  end

  before { stub_const("#{described_class}::CRITERIAS_PATH", -> { 'spec/fixtures/criterias/housing.service_offerings.yml' }) }

  context 'with matches' do
    it { expect(operation.scope).to include(service_offering) }
  end

  context 'without matches' do
    before { housing.update_attributes(resources: 0) }

    it { expect(operation.scope).not_to include(service_offering) }
  end
end
