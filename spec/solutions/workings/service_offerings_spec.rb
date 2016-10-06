# encoding: utf-8
# frozen_string_literal: true

situation %(
  Quand Chlotilde, 22 ans, sans activité après d’avoir quitté la fac en 1er,
  Est à la recherche de son premier travail,
  Elle veut savoir qui peut l’aider dans sa recherche,
  Elle veut savoir qui peut l’aider à améliorer son CV,
  Elle veut savoir qui peut l'aider avec ses entretiens,
  Pour se sentir accompagnée,
  Et trouver un travail rapidement.
) do
  given(:public_service)    { create(:public_service, title: 'APEC') }
  given!(:service_offering) { create(:service_offering, title: 'Améliorer mon CV', public_service: public_service) }

  background do
    Working::ServiceOfferings.send(:remove_const, 'CRITERIAS_PATH')
    Working::ServiceOfferings.const_set('CRITERIAS_PATH', 'spec/fixtures/criterias/working.service_offerings.yml')
    create(:feature, :working)
  end

  solution('Improve my résumé') do
    scenario 'aware' do
      visit('/')
      click_link('Commencer !')

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
      click_button('Continuer')

      # There're services offered to Chlotilde
      expect(page).to have_content('Améliorer mon CV')

      # Chlotilde wants to discover what's the service about
      click_link('Découvrir')

      # She wants to be recontacted
      fill_in('contact[email_or_phone]', with: 'chlotilde@contactez.moi')
      click_button('Envoyer !')

      # She's notified she'll be contacted
      expect(page)
        .to(
          have_content(
            "Un·e professionnel·le va te contacter dans un délai de #{service_offering.response_time_upper_bound} jours"
          )
        )

      # The professional receives an email...
      open_email(service_offering.email)

      # with all the infos required to change the young's life !
      expect(current_email.from).to eq(ENV['CONTACT_EMAIL'])
      expect(current_email.subject).to eq('Boussole : Un·e jeune veut être recontacté·e !')
      expect(current_email.body).to have_content(service.awareness)
      expect(current_email.body).to have_content(service.sector)
      expect(current_email.body).to have_content(service.duration)
      expect(current_email.body).to have_content(service.engagement)
      expect(current_email.body).to have_content(service.city)
      expect(current_email.body).to have_content(service.last_class)
      expect(current_email.body).to have_content(service.status)
      expect(current_email.body).to have_content(service.age)
    end
  end
end
