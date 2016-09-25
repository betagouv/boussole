# encoding: utf-8
# frozen_string_literal: true

RSpec.describe 'Housing matching criterias', type: :criteria do
  criterias = YAML.load(File.read(Rails.root.join('config/criterias/reims/housing.service_offerings.yml')))
  let(:klass) { Housing }

  # TODO: Refacto to rules object
  # TODO: Use RSpec hash/custom matchers
  criterias.each do |public_service_key, public_service|
    it { expect(public_service_key).to match(/\A[a-z0-9\-]+\z/) }

    public_service.each do |service_offering_key, scenarios|
      it { expect(service_offering_key).to match(/\A[a-z0-9\-]+\z/) }

      scenarios.each do |conditions|
        conditions.each do |condition|
          # Valid keys
          it { expect(condition.keys).to eq(%w(attribute operator value)) }

          # TODO: Define a (custom) compound matcher for this
          # Whether the attribute is a valid housing attribute
          it { expect(klass.column_names).to include(condition['attribute']) }

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
