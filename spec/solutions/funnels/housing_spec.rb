# encoding: utf-8
# frozen_string_literal: true

solution('Find a flatsharing solution') do
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
      allow(Rails.application.config).to receive(:rhizome) { 'essonne' }
      allow(Housing::ServiceOfferings)
        .to(
          receive(:criteria_path) {
            'spec/fixtures/criteria/housing.service_offerings.yml'
          }
        )
    end

    scenario do
      visit('/')
      click_link('Logement')

      # Duration
      select('1 an', from: 'Je cherche un logement pour…')

      # Desired location
      select('Égly', from: 'Où souhaite-je me loger ?')

      # Budget
      fill_in('Quel est mon budget mensuel pour me loger (€) ?', with: 300)

      # Submit!
      click_button('Continuer')

      # Current status
      select('Lycéen·ne', from: "Quelle est ma situation aujourd'hui ?")

      # Next status
      check('Serai-je étudiant·e à la rentrée ?', match: :first)

      # Current location
      select('Ollainville', from: 'Lieu de résidence actuel ?')

      # Age
      select('18', from: 'Quel est mon âge ?')

      # Submit!
      click_button('Finir !')

      # There're services offered to Zoe
      expect(page).to have_content('Trouver un coloc')

      # Zoe wants to discover what's the service about
      click_link('Découvres-en plus', match: :first)

      # She wants to be recontacted, but forgets to type in her email or phone number
      click_button('Obtiens un RDV')

      # She's notified she has to type in her email or phone in order to be contacted
      expect(page).to have_content(/doit être rempli·e/)

      fill_in('contact[email_or_phone]', with: 'zoe@contactez.moi')
      click_button('Obtiens un RDV')

      # She's notified she'll be contacted
      expect(page).to have_content(/dans un délai de #{service.response_time_upper_bound} jours/)

      # The professional receives an email...
      open_email(service.email)

      # with all the infos required to change the young's life !
      expect(current_email.from).to include(ENV['CONTACT_EMAIL'])
      expect(current_email.subject).to eq('Boussole : Un·e jeune veut être recontacté·e !')
      expect(current_email.body).to have_content('Contact : zoe@contactez.moi')
      expect(current_email.body).to have_content('Service : Trouver un coloc')
      expect(current_email.body).to have_content("Délai garanti de réponse (jours) : #{service.response_time_upper_bound}")
      expect(current_email.body).to have_content('Je cherche un logement pour… : 1 an')
      expect(current_email.body).to have_content('Où souhaite-je me loger ? : Égly')
      expect(current_email.body).to have_content('Quel est mon budget mensuel pour me loger (€) ? : 300')
      expect(current_email.body).to have_content("Quelle est ma situation aujourd'hui ? : Lycéen·ne")
      expect(current_email.body).to have_content('Serai-je étudiant·e à la rentrée ? : Oui')
      expect(current_email.body).to have_content('Lieu de résidence actuel ? : Ollainville')
      expect(current_email.body).to have_content('Quel est mon âge ? : 18')
    end
  end
end
