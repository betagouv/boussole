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

  describe '#siao?' do
    context 'for non urgences' do
      it { expect(build(:housing).siao?).to eq(false) }
    end

    context 'for people with enough resources' do
      let(:housing) { build(:housing, resources: 301) }

      it { expect(housing.siao?).to eq(false) }
    end

    context 'for urgences and without enough resources' do
      let(:housing) { build(:housing, duration: 'Cette nuit', resources: 300) }

      it { expect(housing.siao?).to eq(true) }
    end
  end

  describe '#crous?' do
    context 'for more than a year' do
      let(:housing) { build(:housing, duration: "+ d'1 an") }

      it { expect(housing.crous?).to eq(false) }
    end

    context 'for a non student' do
      it { expect(build(:housing).crous?).to eq(false) }
    end

    context 'for people with enough resources' do
      let(:housing) { build(:housing, duration: 'Quelques mois', current_status: 'Étudiant·e', resources: 1_201) }

      it { expect(housing.crous?).to eq(false) }
    end

    context 'for students without resources and for no more than a year' do
      let(:housing) { build(:housing, duration: 'Quelques mois', current_status: 'Étudiant·e', resources: 1_200) }

      it { expect(housing.crous?).to eq(true) }
    end

    context 'for students without resources and for a year' do
      let(:housing) { build(:housing, duration: '1 an', current_status: 'Étudiant·e', resources: 1_200) }

      it { expect(housing.crous?).to eq(true) }
    end
  end

  describe '#paindavoine?' do
    context 'for urgences' do
      let(:housing) { build(:housing, duration: 'Cette nuit') }

      it { expect(housing.paindavoine?).to eq(false) }
    end

    context 'for students' do
      let(:housing) { build(:housing, current_status: 'Étudiant·e') }

      it { expect(housing.paindavoine?).to eq(false) }
    end

    context 'for people without enough resources' do
      let(:housing) { build(:housing, resources: 299) }

      it { expect(housing.paindavoine?).to eq(false) }
    end

    context 'for non urgences, highschooler and with enough resources' do
      let(:housing) { build(:housing, current_status: 'Lycéen·ne', resources: 300) }

      it { expect(housing.paindavoine?).to eq(false) }
    end

    context 'for non urgences, students and with enough resources' do
      let(:housing) { build(:housing, current_status: 'Lycéen·ne', next_status: true, resources: 300) }

      it { expect(housing.paindavoine?).to eq(true) }
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

    context 'for really young people' do
      let(:housing) { build(:housing, age: 15) }

      it { expect(housing.cent_quinze?).to eq(false) }
    end

    context 'for not-so-young adults' do
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
    context 'for urgences' do
      let(:housing) { build(:housing, duration: 'Cette nuit', current_status: 'Étudiant·e') }

      it { expect(housing.cle?).to eq(false) }
    end

    context 'for non students' do
      it { expect(build(:housing).cle?).to eq(false) }
    end

    context 'for non urgences' do
      let(:housing) { build(:housing, current_status: 'Étudiant·e') }

      it { expect(housing.cle?).to eq(true) }
    end
  end

  describe '#locapass?' do
    context 'for urgences' do
      let(:housing) { build(:housing, duration: 'Cette nuit', current_status: 'Salarié·e') }

      it { expect(housing.locapass?).to eq(false) }
    end

    context 'for not-so-young adults' do
      let(:housing) { build(:housing, age: 30) }

      it { expect(housing.locapass?).to eq(false) }
    end

    context 'for employees' do
      let(:housing) { build(:housing, current_status: 'Salarié·e') }

      it { expect(housing.locapass?).to eq(true) }
    end

    context "for young people undertaking an 'alternance'" do
      let(:housing) { build(:housing, current_status: 'En alternance', age: 29) }

      it { expect(housing.locapass?).to eq(true) }
    end

    context 'for young job seekers' do
      let(:housing) { build(:housing, current_status: 'Sans activité', age: 29) }

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
      let(:housing) { build(:housing, duration: '1 an', current_status: 'Salarié·e') }

      it { expect(housing.visale?).to eq(true) }
    end

    context 'for more than a year and for employees' do
      let(:housing) { build(:housing, duration: "+ d'1 an", current_status: 'Salarié·e') }

      it { expect(housing.visale?).to eq(true) }
    end
  end

  describe '#student?' do
    it { expect(build(:housing, current_status: 'Étudiant·e', next_status: false).student?).to eq(true) }
    it { expect(build(:housing, current_status: 'Lycéen·ne', next_status: true).student?).to eq(true) }
    it { expect(build(:housing, next_status: true).student?).to eq(false) }
  end
end
