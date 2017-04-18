# encoding: utf-8
# frozen_string_literal: true

RSpec.describe WorkingAge, type: :model do
  it_should_behave_like :belonging_to, :target_public
  it_should_behave_like :continuous

  it 'validates that the #minimum is at least 16 and no more than 30' do
    is_expected.to(
      validate_numericality_of(:minimum)
        .is_greater_than_or_equal_to(16)
        .is_less_than_or_equal_to(30)
        .only_integer
        .allow_nil
    )
  end

  it 'validates that the #maximum is at least 16 and no more than 30' do
    is_expected.to(
      validate_numericality_of(:maximum)
        .is_greater_than_or_equal_to(16)
        .is_less_than_or_equal_to(30)
        .only_integer
        .allow_nil
    )
  end
end
