# encoding: utf-8
# frozen_string_literal: true

solution 'Talk to a human' do
  situation %(
    Quand j'utilise la Boussole pour être recontacté·e par un·e professionnel·le,
    Et que je ne comprends pas comment avancer,
    Je veux pouvoir contacter quelqu'un·e,
    Afin d'aller jusqu'au but,
    Et de découvrir à quoi je suis éligible,
    Ou avec qui je peux rentrer en contact.
  ) do
    background do
      allow(Flip).to receive(:on?)
      allow(Flip).to receive(:on?).with(:talk_to_a_human) { true }
    end

    scenario do
      visit('/')
      click_link('Emploi')

      expect(page).to have_link('Contacte nous :)', href: /#{ENV['CONTACT_EMAIL']}/)
    end
  end

  situation %(
    Quand j'utilise la Boussole pour être recontacté·e par un·e professionnel·le,
    Mais que je ne trouve pas des résultats pour moi,
    Je veux pouvoir contacter quelqu'un·e,
    Afin de découvrir à quoi je suis éligible,
    Ou avec qui je peux rentrer en contact.
  ) do

    given(:working) { create(:working) }

    background do
      allow(Flip).to receive(:on?)
      allow(Flip).to receive(:on?).with(:working) { true }
      allow(Flip).to receive(:on?).with(:talk_to_a_human) { true }
    end

    scenario do
      visit(working_path(working))

      expect(page).to have_content("Mais nous sommes à ta disposition pour t'aider à trouver le bon contact !")
    end
  end
end
