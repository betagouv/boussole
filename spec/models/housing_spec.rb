# encoding: utf-8
# frozen_string_literal: true

RSpec.describe Housing, type: :model do
  context 'validations' do
    context 'housing' do
      subject { build(:housing, :housing) }

      it { is_expected.to validate_presence_of(:duration) }
      it { is_expected.to validate_inclusion_of(:duration).in_array(DURATIONS) }

      it { is_expected.to validate_presence_of(:housing_city) }
    end

    context 'profile' do
      subject { build(:housing, :profile) }

      it { is_expected.to validate_presence_of(:current_status) }
      it { is_expected.to validate_inclusion_of(:current_status).in_array(STATUSES) }

      it { is_expected.to validate_presence_of(:age) }
    end
  end

  describe '#match' do
    let(:public_service)   { create(:public_service, title: 'SIAO') }
    let(:service_offering) { create(:service_offering, title: 'Solution logement urgence', public_service: public_service) }

    let(:housing) do
      create(
        :housing,
        duration: '1 an',
        housing_city: 'Reims',
        current_status: 'Étudiant·e',
        resources: 150
      )
    end

    before do
      allow(housing).to receive(:rules) do
        {
          'siao' => {
            'solution-logement-urgence' => [
              [
                {
                  'attribute' => 'duration',
                  'operator' => 'in?',
                  'value' => ['Quelques mois', '1 an', "+ d'1 an"]
                },
                {
                  'attribute' => 'resources',
                  'operator' => '>=',
                  'value' => 150
                },
                {
                  'attribute' => 'current_status',
                  'operator' => 'in?',
                  'value' => ['Étudiant·e', 'Lycéen·ne', 'Salarié·e', 'En formation', 'Apprenti·e']
                }
              ]
            ]
          }
        }
      end
    end

    context 'with matches' do
      it { expect(housing.matches).to include(service_offering) }
    end

    context 'without matches' do
      before { housing.update_attributes(resources: 0) }

      it { expect(housing.matches).to be_empty }
    end
  end

  # TODO: Refacto to rules object
  # TODO: Use RSpec hash/custom matchers
  describe '#rules' do
    rules = YAML.load(File.read(Rails.root.join('config', 'rules', 'reims', 'service_offerings.yml')))

    rules.each do |public_service_key, public_service|
      it { expect(public_service_key).to match(/\A[a-z0-9\-]+\z/) }

      public_service.each do |service_offering_key, scenarios|
        it { expect(service_offering_key).to match(/\A[a-z0-9\-]+\z/) }

        scenarios.each do |conditions|
          conditions.each do |condition|
            # Valid keys
            it { expect(condition.keys).to eq(%w(attribute operator value)) }

            # TODO: Define a (custom) compound matcher for this
            # Whether the attribute is a valid housing attribute
            it { expect(described_class.column_names).to include(condition['attribute']) }

            # TODO: Define a (custom) compound matcher for this
            # Permitted operators
            it { expect(%w(in? == != < <= >= >)).to include(condition['operator']) }

            # Value should either be an array, a string or a number
            it { expect(condition['value']).to be_a_kind_of(Array) | be_a_kind_of(String) | be_a_kind_of(Integer) }

            case condition['attribute']
            when 'duration'
              # Whether the duration value/s are valid or not
              # TODO: Define a custom matcher!
              it { expect(Array.wrap(condition['value']).to_set.subset?(DURATIONS.to_set)).to be(true) }
              it { expect(%w(in? == !=)).to include(condition['operator']) }
              it { expect(condition['value']).to be_a_kind_of(Array) } if condition['operator'] == 'in?'
              it { expect(condition['value']).to be_a_kind_of(String) } if condition['operator'].in?(%w(== !=))

            when 'current_status'
              # Whether the current_status value/s are valid or not
              # TODO: Define a custom matcher!
              it { expect(Array.wrap(condition['value']).to_set.subset?(STATUSES.to_set)).to be(true) }
              it { expect(%w(in? ==)).to include(condition['operator']) }
              it { expect(condition['value']).to be_a_kind_of(Array) } if condition['operator'] == 'in?'
              it { expect(condition['value']).to be_a_kind_of(String) } if condition['operator'].in?(%w(== !=))

            when /resources|age/
              # Whether the resources or age value/s are valid or not
              it { expect(%w(in?)).not_to include(condition['operator']) }
              it { expect(condition['value']).to be_a_kind_of(Integer) }

            when /housing_city|residence_city/
              it { expect(%w(== !=)).to include(condition['operator']) }

            when 'next_status'
              it { expect(condition['value']).to be(true) }
            end
          end
        end
      end
    end
  end
end
