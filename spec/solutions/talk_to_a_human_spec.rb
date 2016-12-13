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
      allow(Flip).to receive(:on?).with(:working) { true }
      allow(Flip).to receive(:on?).with(:talk_to_a_human) { true }
    end

    scenario do
      visit('/')
      click_link('Commencer !')

      expect(page).to have_link('Contacte nous :)', href: /#{ENV['CONTACT_EMAIL']}/)
    end
  end
end
