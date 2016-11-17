# encoding: utf-8
# frozen_string_literal: true

situation %(
  Quand Zoe, 18 ans, bachelière, qui va bientôt commencer ses études,
  Veut trouver un logement en colocation pour la rentrée,
  Elle veut savoir quels sites d'internet proposent d'offres de colocation,
  Elle veut savoir qui peut l'orienter dans sa recherche,
  Elle veut entrer en contact avec quelqu'un qui puisse l'aider dans sa recherche,
  Ses parents veulent connaître les aides disponibles pour leur situation,
  Pour pouvoir gagner du temps,
  Et trouver un logement rapidement.
) do
  given(:public_service) { create(:public_service, title: 'Lokaviz') }
  given!(:service)       { create(:service_offering, title: 'Trouver un coloc', public_service: public_service) }

  background do
    allow(Flip).to receive(:on?)
    allow(Flip).to receive(:on?).with(:housing) { true }
    allow(Rails.root).to receive(:join) { 'spec/fixtures/criterias/housing.service_offerings.yml' }
  end

  solution('Find a flatsharing solution') do
    scenario('She knows what she wants to do') do
      visit('/')
      click_link('Commencer !')

      # Duration
      select('1 an', from: 'Pour combien de temps ?')

      # Desired location
      select('Reims', from: 'Où souhaites-tu te loger ?')

      # Budget
      fill_in('Quel est ton budget mensuel pour te loger (€) ?', with: 300)

      # Submit!
      click_button('Continuer')

      # Current status
      select('Lycéen·ne', from: "Quelle est ta situation aujourd'hui ?")

      # Next status
      check('Seras-tu étudiant·e à la rentrée ?', match: :first)

      # Age
      fill_in('Tu as quel âge ?', with: 18)

      # Submit!
      click_button('Continuer')

      # There're services offered to Zoe
      expect(page).to have_content('Trouver un coloc')
    end
  end
end
