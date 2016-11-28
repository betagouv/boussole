# encoding: utf-8
# frozen_string_literal: true

situation %(
  Quand j'utilise la Boussole pour être recontacté·e par un·e professionnel·le,
  Et que je ne comprends pas comment avancer,
  Je veux pouvoir me faire aider par quelqu'un·e,
  Afin d'aller jusqu'au but,
  Et de découvrir à quoi je suis éligible,
  Ou avec qui je peux rentrer en contact.
) do
  background do
    allow(Flip).to receive(:on?)
    allow(Flip).to receive(:on?).with(:working) { true }
  end

  scenario("I'm lost in the middle of the form") do
    visit('/')
    click_link('Commencer !')

    expect(page).to have_link("As-tu besoin d'aide ?", href: /#{ENV['CONTACT_EMAIL']}/)
  end
end
