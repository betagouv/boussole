# encoding: utf-8
# frozen_string_literal: true

RSpec.describe Housing, type: :model do
  describe '#siao?' do
    context 'for non urgences' do
      let(:housing) do
        build(
          :housing,
          duration: "> d'1 an",
          status: 'Étudiant·e',
          resources: 299
        )
      end

      it { expect(housing.siao?).to eq(false) }
    end

    context 'for people with enough resources' do
      let(:housing) do
        build(
          :housing,
          duration: nil,
          status: 'Sans activité',
          resources: 300
        )
      end

      it { expect(housing.siao?).to eq(false) }
    end

    context 'for urgences and without enough resources' do
      let(:housing) do
        build(
          :housing,
          duration: 'Cette nuit',
          status: 'Salarié·e',
          resources: 299
        )
      end

      it { expect(housing.siao?).to eq(true) }
    end
  end

  describe '#crous?' do
    context 'for more than a year' do
      let(:housing) do
        build(
          :housing,
          duration: "> d'1 an",
          status: 'Étudiant·e',
          resources: 1234
        )
      end

      it { expect(housing.crous?).to eq(false) }
    end

    context 'for a non student' do
      let(:housing) do
        build(
          :housing,
          duration: '1 an',
          status: 'Sans activité',
          resources: 1234
        )
      end

      it { expect(housing.crous?).to eq(false) }
    end

    context 'for students and no more than a year' do
      let(:housing) do
        build(
          :housing,
          duration: 'Quelques mois',
          status: 'Étudiant·e',
          resources: 1234
        )
      end

      it { expect(housing.crous?).to eq(true) }
    end

    context 'for students and a year' do
      let(:housing) do
        build(
          :housing,
          duration: '1 an',
          status: 'Étudiant·e',
          resources: 1234
        )
      end

      it { expect(housing.crous?).to eq(true) }
    end
  end

  describe '#pain_d_avoine?' do
    context 'for urgences' do
      let(:housing) do
        build(
          :housing,
          duration: 'Cette nuit',
          status: 'Sans activité',
          resources: 300
        )
      end

      it { expect(housing.pain_d_avoine?).to eq(false) }
    end

    context 'for students' do
      let(:housing) do
        build(
          :housing,
          duration: '1 an',
          status: 'Étudiant·e',
          resources: 300
        )
      end

      it { expect(housing.pain_d_avoine?).to eq(false) }
    end

    context 'for people without enough resources' do
      let(:housing) do
        build(
          :housing,
          duration: '1 an',
          status: 'Sans activité',
          resources: 299
        )
      end

      it { expect(housing.pain_d_avoine?).to eq(false) }
    end

    context 'for non urgences, non students and with enough resources' do
      let(:housing) do
        build(
          :housing,
          duration: '1 an',
          status: 'Sans activité',
          resources: 300
        )
      end

      it { expect(housing.pain_d_avoine?).to eq(true) }
    end
  end

  describe '#apl?' do
    context 'for urgences' do
      let(:housing) do
        build(
          :housing,
          duration: 'Cette nuit',
          status: 'Étudiant·e',
          resources: 1234
        )
      end

      it { expect(housing.apl?).to eq(false) }
    end

    context 'for non urgences' do
      let(:housing) do
        build(
          :housing,
          duration: '1 an',
          status: 'Étudiant·e',
          resources: 1234
        )
      end

      it { expect(housing.apl?).to eq(true) }
    end
  end

  describe '#cle?' do
    context 'for non students' do
      let(:housing) do
        build(
          :housing,
          duration: 'Cette nuit',
          status: 'Sans activité',
          resources: 1234
        )
      end

      it { expect(housing.cle?).to eq(false) }
    end

    context 'for non urgences' do
      let(:housing) do
        build(
          :housing,
          duration: '1 an',
          status: 'Étudiant·e',
          resources: 1234
        )
      end

      it { expect(housing.cle?).to eq(true) }
    end
  end

  describe '#locapass?' do
    context 'for oldies' do
      let(:housing) do
        build(
          :housing,
          duration: '1 an',
          status: 'Alternance',
          resources: 1234,
          age: 30
        )
      end

      it { expect(housing.locapass?).to eq(false) }
    end

    context 'for employees' do
      let(:housing) do
        build(
          :housing,
          duration: '1 an',
          status: 'Salarié·e',
          resources: 1234,
          age: 30
        )
      end

      it { expect(housing.locapass?).to eq(true) }
    end

    context "for young people undertaking an 'alternance'" do
      let(:housing) do
        build(
          :housing,
          duration: '1 an',
          status: 'En alternance',
          resources: 1234,
          age: 29
        )
      end

      it { expect(housing.locapass?).to eq(true) }
    end

    context 'for young job seekers' do
      let(:housing) do
        build(
          :housing,
          duration: '1 an',
          status: 'Sans activité',
          resources: 1234,
          age: 29
        )
      end

      it { expect(housing.locapass?).to eq(true) }
    end
  end

  describe '#visale?' do
    context 'for less than a year' do
      let(:housing) do
        build(
          :housing,
          duration: 'Quelques mois',
          status: 'Salarié·e'
        )
      end

      it { expect(housing.visale?).to eq(false) }
    end

    context 'for non employees' do
      let(:housing) do
        build(
          :housing,
          duration: '1 an',
          status: 'Sans activité'
        )
      end

      it { expect(housing.visale?).to eq(false) }
    end

    context 'for a year and for employees' do
      let(:housing) do
        build(
          :housing,
          duration: "> d'1 an",
          status: 'Salarié·e'
        )
      end

      it { expect(housing.visale?).to eq(true) }
    end

    context 'for more than a year and for employees' do
      let(:housing) do
        build(
          :housing,
          duration: "> d'1 an",
          status: 'Salarié·e'
        )
      end

      it { expect(housing.visale?).to eq(true) }
    end
  end
end
