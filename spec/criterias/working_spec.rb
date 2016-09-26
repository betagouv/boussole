# encoding: utf-8
# frozen_string_literal: true

RSpec.describe 'Working matching criterias', type: :criteria do
  criterias = YAML.load(File.read(Rails.root.join('config/criterias/reims/working.service_offerings.yml')))

  # TODO: Refacto to rules object
  # TODO: Use RSpec hash/custom matchers
  criterias.each do |public_service_slug, public_service|
    it { expect(public_service_slug).to be_a_kind_of_slug }

    public_service.each do |service_offering_slug, scenarios|
      it { expect(service_offering_slug).to be_a_kind_of_slug }

      scenarios.each do |conditions|
        conditions.each do |condition|
          # Valid keys
          it { expect(condition.keys).to eq(%w(attribute operator value)) }

          # Whether the attribute is a valid attribute
          it { expect(condition['attribute']).to be_included_in(Working.column_names) }

          # Permitted operators
          it { expect(condition['operator']).to be_included_in(%w(in? == != < <= >= >)) }

          # Permitted values for inclusion delimiters
          it { expect(condition['value']).to be_included_in_delimiter_for(Working, condition['attribute']) }

          # Value should either be an array, a string, an integer or a boolean
          it { expect(condition['value']).to be_any_kind_of(Array, String, Integer, TrueClass, FalseClass) }
          it { expect(condition['operator']).to be_included_in(%w(in?)) if condition['value'].is_a?(Array) }
          it { expect(condition['operator']).to be_included_in(%w(== !=)) if condition['value'].is_a?(String) }
          it { expect(condition['operator']).to be_included_in(%w(== != < <= >= >)) if condition['value'].is_a?(Integer) }
          it { expect(condition['operator']).to be_included_in(%w(==)) if condition['value'].is_a?(TrueClass) }
          it { expect(condition['operator']).to be_included_in(%w(==)) if condition['value'].is_a?(FalseClass) }

          case Working.columns_hash[condition['attribute']].type
          when :integer
            it { expect(condition['value']).to be_a_kind_of(Integer) }
          when :string
            it { expect(condition['value']).to be_any_kind_of(Array, String) }
          when :boolean
            it { expect(condition['value']).to be_any_kind_of(TrueClass, FalseClass) }
          end
        end
      end
    end
  end
end
