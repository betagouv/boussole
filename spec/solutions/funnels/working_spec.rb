# encoding: utf-8
# frozen_string_literal: true

solution('Improve my CV') do
  situation %(
    Quand Chlotilde, 22 ans, sans activité après d’avoir quitté la fac en 1er,
    Est à la recherche de son premier travail,
    Elle veut savoir qui peut l’aider dans sa recherche,
    Elle veut savoir qui peut l’aider à améliorer son CV,
    Elle veut savoir qui peut l'aider avec ses entretiens,
    Pour se sentir accompagnée,
    Et trouver un travail rapidement.
  ) do
    given(:public_service) { create(:public_service, title: 'APEC') }
    given!(:service)       { create(:service_offering, title: 'Améliorer mon CV', public_service: public_service) }

    background do
      Working::ServiceOfferings.send(:remove_const, 'CRITERIAS_PATH')
      Working::ServiceOfferings.const_set('CRITERIAS_PATH', -> { 'spec/fixtures/criterias/working.service_offerings.yml' })
    end

    scenario('she knows what she wants to do') do
      visit('/')
      click_link('Emploi')

      # Knowledge
      choose('Je sais ce que je veux faire')

      # Submit!
      click_button('Continuer')

      # Sector
      select('Agriculture', from: "Secteur d'activité")

      # Experience
      choose('Non')

      # Duration
      select('1 an', from: 'Je cherche un emploi pour…')

      # Engagement
      select('Mi-temps', from: 'Combien de temps puis-je y consacrer ?')

      # Submit!
      click_button('Continuer')

      # Status
      select('Sans activité', from: "Quelle est ma situation aujourd'hui ?")

      # Age
      select('22', from: 'Quel est mon âge ?')

      # Handicap
      choose('Non')

      # Last class
      select('Études supérieures', from: 'Dernières études suivies')

      # City
      select('Reims', from: 'Ville de résidence')

      # Submit!
      click_button('Continuer')

      # Pôle emploi
      within('.working_pole_emploi') { choose('Non') }

      # Mission locale
      within('.working_mission_locale') { choose('Non') }

      # Cap emploi
      within('.working_cap_emploi') { choose('Non') }

      # APEC
      within('.working_apec') { choose('Non') }

      # Submit!
      click_button('Finir !')

      # There're services offered to Chlotilde
      expect(page).to have_content('Améliorer mon CV')

      # Chlotilde wants to discover what's the service about
      click_link('Découvres-en plus', match: :first)

      # She wants to be recontacted, but forgets to type in her email or phone number
      click_button('Obtiens un RDV')

      # She's notified she has to type in her email or phone in order to be contacted
      expect(page).to have_content(/doit être rempli·e/)

      fill_in('contact[email_or_phone]', with: 'chlotilde@contactez.moi')
      click_button('Obtiens un RDV')

      # She's notified she'll be contacted
      expect(page).to have_content(/dans un délai de #{service.response_time_upper_bound} jours/)

      # The professional receives an email...
      open_email(service.email)

      # with all the infos required to change the young's life !
      expect(current_email.from).to include(ENV['CONTACT_EMAIL'])
      expect(current_email.subject).to eq('Boussole : Un·e jeune veut être recontacté·e !')
      expect(current_email.body).to have_content('Contact : chlotilde@contactez.moi')
      expect(current_email.body).to have_content('Service : Améliorer mon CV')
      expect(current_email.body).to have_content("Délai garanti de réponse (jours) : #{service.response_time_upper_bound}")
      expect(current_email.body).to have_content('Sais-je ce que je veux faire ? : Je sais ce que je veux faire')
      expect(current_email.body).to have_content("Secteur d'activité : Agriculture")
      expect(current_email.body).to have_content("J'ai déjà une expérience dans ce secteur : Non")
      expect(current_email.body).to have_content('Je cherche un emploi pour… : 1 an')
      expect(current_email.body).to have_content('Combien de temps puis-je y consacrer ? : Mi-temps')
      expect(current_email.body).to have_content("Quelle est ma situation aujourd'hui ? : Sans activité")
      expect(current_email.body).to have_content('Quel est mon âge ? : 22')
      expect(current_email.body).to have_content('Dernières études suivies : Études supérieures')
      expect(current_email.body).to have_content('Pôle emploi ? : Non')
      expect(current_email.body).to have_content('Mission locale ? : Non')
      expect(current_email.body).to have_content('Cap emploi ? : Non')
      expect(current_email.body).to have_content("Association pour l'emploi des cadres (APEC) ? : Non")
    end
  end
end
