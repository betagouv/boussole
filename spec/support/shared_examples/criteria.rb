# encoding: utf-8
# frozen_string_literal: true

RSpec.shared_examples :criteria do |klass, criteria|
  # TODO: Refacto to rules object
  # TODO: Use RSpec hash/custom matchers
  criteria.each do |public_service_slug, public_service|
    it { expect(public_service_slug).to be_a_kind_of_slug }

    public_service.each do |service_offering_slug, scenarios|
      it { expect(service_offering_slug).to be_a_kind_of_slug }

      scenarios.each do |conditions|
        conditions.each do |condition|
          # Valid keys
          it { expect(condition.keys).to eq(%w(attribute operator value)) }

          # Whether the attribute is a valid attribute
          it { expect(condition['attribute']).to be_included_in(klass.column_names) }

          # Permitted operators
          it { expect(condition['operator']).to be_included_in(%w(in? == != < <= >= >)) }

          # Permitted values for inclusion delimiters
          it { expect(condition['value']).to be_included_in_delimiter_for(klass, condition['attribute']) }

          # Value should either be an array, a string, an integer or a boolean
          it { expect(condition['value']).to be_any_kind_of(Array, String, Integer, TrueClass, FalseClass) }
          it { expect(condition['operator']).to be_included_in(%w(in?)) if condition['value'].is_a?(Array) }
          it { expect(condition['operator']).to be_included_in(%w(== !=)) if condition['value'].is_a?(String) }
          it { expect(condition['operator']).to be_included_in(%w(== != < <= >= >)) if condition['value'].is_a?(Integer) }
          it { expect(condition['operator']).to be_included_in(%w(==)) if condition['value'].is_a?(TrueClass) }
          it { expect(condition['operator']).to be_included_in(%w(==)) if condition['value'].is_a?(FalseClass) }

          case klass.columns_hash[condition['attribute']].type
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
