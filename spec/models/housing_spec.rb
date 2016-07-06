# encoding: utf-8
# frozen_string_literal: true

RSpec.describe Housing, type: :model do
  context 'validations' do
    context 'housing' do
      subject { build(:housing, :housing) }

      it { is_expected.to validate_presence_of(:duration) }
      it { is_expected.to validate_presence_of(:housing_city) }
      it { is_expected.to validate_presence_of(:resources) }
    end

    context 'profile' do
      subject { build(:housing, :profile) }

      it { is_expected.to validate_presence_of(:status) }
      it { is_expected.to validate_presence_of(:residence_city) }
      it { is_expected.to validate_presence_of(:age) }
    end
  end

  describe '#siao?' do
    context 'for non urgences' do
      it { expect(build(:housing).siao?).to eq(false) }
    end

    context 'for people with enough resources' do
      let(:housing) { build(:housing, resources: 300) }

      it { expect(housing.siao?).to eq(false) }
    end

    context 'for urgences and without enough resources' do
      let(:housing) { build(:housing, duration: 'Cette nuit', resources: 299) }

      it { expect(housing.siao?).to eq(true) }
    end
  end

  describe '#crous?' do
    context 'for more than a year' do
      let(:housing) { build(:housing, duration: "> d'1 an") }

      it { expect(housing.crous?).to eq(false) }
    end

    context 'for a non student' do
      it { expect(build(:housing).crous?).to eq(false) }
    end

    context 'for students and no more than a year' do
      let(:housing) { build(:housing, duration: 'Quelques mois', status: 'Étudiant·e') }

      it { expect(housing.crous?).to eq(true) }
    end

    context 'for students and a year' do
      let(:housing) { build(:housing, duration: '1 an', status: 'Étudiant·e') }

      it { expect(housing.crous?).to eq(true) }
    end
  end

  describe '#pain_d_avoine?' do
    context 'for urgences' do
      let(:housing) { build(:housing, duration: 'Cette nuit') }

      it { expect(housing.pain_d_avoine?).to eq(false) }
    end

    context 'for students' do
      let(:housing) { build(:housing, status: 'Étudiant·e') }

      it { expect(housing.pain_d_avoine?).to eq(false) }
    end

    context 'for people without enough resources' do
      let(:housing) { build(:housing, resources: 299) }

      it { expect(housing.pain_d_avoine?).to eq(false) }
    end

    context 'for non urgences, non students and with enough resources' do
      let(:housing) { build(:housing, resources: 300) }

      it { expect(housing.pain_d_avoine?).to eq(true) }
    end
  end

  describe '#cent_quinze?' do
    context 'for non urgences' do
      it { expect(build(:housing).cent_quinze?).to eq(false) }
    end

    context 'for people with enough resources' do
      let(:housing) { build(:housing, resources: 1_001) }

      it { expect(housing.cent_quinze?).to eq(false) }
    end

    context 'for kids' do
      let(:housing) { build(:housing, age: 15) }

      it { expect(housing.cent_quinze?).to eq(false) }
    end

    context 'for oldies' do
      let(:housing) { build(:housing, age: 31) }

      it { expect(housing.cent_quinze?).to eq(false) }
    end

    context 'for urgences, for young people without enough resources' do
      let(:housing) do
        build(
          :housing,
          duration: 'Cette nuit',
          resources: 1_000,
          age: 30
        )
      end

      it { expect(housing.cent_quinze?).to eq(true) }
    end
  end

  describe '#apl?' do
    context 'for urgences' do
      let(:housing) { build(:housing, duration: 'Cette nuit') }

      it { expect(housing.apl?).to eq(false) }
    end

    context 'for non urgences' do
      it { expect(build(:housing).apl?).to eq(true) }
    end
  end

  describe '#cle?' do
    context 'for non students' do
      let(:housing) { build(:housing, duration: 'Cette nuit') }

      it { expect(build(:housing).cle?).to eq(false) }
    end

    context 'for non urgences' do
      let(:housing) { build(:housing, status: 'Étudiant·e') }

      it { expect(housing.cle?).to eq(true) }
    end
  end

  describe '#locapass?' do
    context 'for oldies' do
      let(:housing) { build(:housing, age: 30) }

      it { expect(housing.locapass?).to eq(false) }
    end

    context 'for employees' do
      let(:housing) { build(:housing, status: 'Salarié·e') }

      it { expect(housing.locapass?).to eq(true) }
    end

    context "for young people undertaking an 'alternance'" do
      let(:housing) { build(:housing, status: 'En alternance', age: 29) }

      it { expect(housing.locapass?).to eq(true) }
    end

    context 'for young job seekers' do
      let(:housing) { build(:housing, status: 'Sans activité', age: 29) }

      it { expect(housing.locapass?).to eq(true) }
    end
  end

  describe '#visale?' do
    context 'for less than a year' do
      let(:housing) { build(:housing, duration: 'Quelques mois') }

      it { expect(housing.visale?).to eq(false) }
    end

    context 'for non employees' do
      it { expect(build(:housing).visale?).to eq(false) }
    end

    context 'for a year and for employees' do
      let(:housing) { build(:housing, duration: '1 an', status: 'Salarié·e') }

      it { expect(housing.visale?).to eq(true) }
    end

    context 'for more than a year and for employees' do
      let(:housing) { build(:housing, duration: "> d'1 an", status: 'Salarié·e') }

      it { expect(housing.visale?).to eq(true) }
    end
  end
end
