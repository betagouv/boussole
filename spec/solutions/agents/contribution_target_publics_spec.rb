# encoding: utf-8
# frozen_string_literal: true

situation %(
  Quand les professionnel·le·s créent un service,
  Ils veulent définir eux-mêmes leur public cible,
  Pour que les jeunes puissent en profiter.) do

  # There are three social rights
  given!(:working)      { create(:social_right, name: 'Emploi') }
  given!(:housing)      { create(:social_right, name: 'Logement') }
  given!(:healthcaring) { create(:social_right, name: 'Santé') }

  # There's one public service
  given!(:public_service) do
    create(
      :public_service,
      title: 'Services Intégrés de l’Accueil et de l’Orientation'
    )
  end

  # There are three service offerings
  given!(:working_service) do
    create(
      :service_offering,
      title: 'Trouver un job étudiant',
      public_service: public_service,
      social_right: working
    )
  end

  given!(:housing_service) do
    create(
      :service_offering,
      title: "Trouver une solution de logement d'urgence",
      public_service: public_service,
      social_right: housing
    )
  end

  given!(:healthcaring_service) do
    create(
      :service_offering,
      title: 'Trouver où se soigner près de chez soi',
      public_service: public_service,
      social_right: healthcaring
    )
  end

  background do
    # There are criteria
    create(:working_status, name: 'Sans activité')
    create(:engagement, name: 'Temps plein')
    create(:working_duration, name: 'Quelques mois')
    create(:last_class, name: 'Collège')
    create(:experience, value: true)
    create(:pole_emploi, value: true)
    create(:mission_locale, value: true)
    create(:cap_emploi, value: true)
    create(:apec, value: true)
    create(:handicap, value: false)
    create(:awareness, name: "Sait ce qu'il·elle veut faire")
    create(:housing_status, name: 'Sans activité')
    create(:housing_duration, name: 'Cette nuit')

    # The agent is at the service offering's space
    visit('/agents/service_offerings')
  end

  solution("Define a service offering's target public") do
    scenario('Working') do
      page.find('tr', text: 'Trouver un job étudiant').click_link('Afficher')
      click_link('Définir un public cible')

      expect(page).to have_content("Cette offre de service s'adresse à tout·e·s les usagers.")

      within('.profile-form') do
        check('target_public[working_status_ids][]', match: :first)
        check('target_public[engagement_ids][]', match: :first)
        check('target_public[working_duration_ids][]', match: :first)
        fill_in('target_public[working_age_attributes][minimum]', with: 16)
        fill_in('target_public[working_age_attributes][maximum]', with: 30)
        check('target_public[last_class_ids][]', match: :first)
        check('target_public[experience_ids][]', match: :first)
        check('target_public[pole_emploi_ids][]', match: :first)
        check('target_public[mission_locale_ids][]', match: :first)
        check('target_public[cap_emploi_ids][]', match: :first)
        check('target_public[apec_ids][]', match: :first)
        check('target_public[handicap_ids][]', match: :first)
        check('target_public[awareness_ids][]', match: :first)

        click_button('Modifier', match: :first)
      end

      expect(page).to have_content('Public cible modifié·e avec succès')
      expect(page).to have_content("Cette offre de service s'adresse aux usagers suivants :")
      expect(page).to have_content('dont le statut est : sans activité')
      expect(page).to have_content('dont la disponibilité est : temps plein')
      expect(page).to have_content('pour une durée de : quelques mois')
      expect(page).to have_content("dont l'âge est compris entre 16 et 30 ans")
      expect(page).to have_content("dont le niveau d'études est : collège")
      expect(page).to have_content('qui a une expérience dans le secteur : oui')
      expect(page).to have_content('qui est inscrit·e à Pôle Emploi : oui')
      expect(page).to have_content('qui est inscrit·e à une mission locale : oui')
      expect(page).to have_content('qui a une expérience dans le secteur : oui')
      expect(page).to have_content("qui est inscrit·e à l'Apec : oui")
      expect(page).to have_content('qui est en situation de handicap : non')
      expect(page).to have_content("qui sait ce qu'il·elle veut faire")
    end

    scenario('Housing') do
      page.find('tr', text: "Trouver une solution de logement d'urgence").click_link('Afficher')
      click_link('Définir un public cible')

      expect(page).to have_content("Cette offre de service s'adresse à tout·e·s les usagers.")

      within('.profile-form') do
        check('target_public[housing_status_ids][]', match: :first)
        check('target_public[housing_duration_ids][]', match: :first)
        fill_in('target_public[housing_age_attributes][minimum]', with: 16)
        fill_in('target_public[housing_age_attributes][maximum]', with: 30)
        fill_in('target_public[resource_attributes][minimum]', with: 300)
        fill_in('target_public[resource_attributes][maximum]', with: 1000)

        click_button('Modifier', match: :first)
      end

      expect(page).to have_content('Public cible modifié·e avec succès')
      expect(page).to have_content("Cette offre de service s'adresse aux usagers suivants :")
      expect(page).to have_content('dont le statut est sans activité')
      expect(page).to have_content('qui souhaite un logement pour cette nuit')
      expect(page).to have_content("dont l'âge est compris entre 16 et 30 ans")
      expect(page).to have_content('dont le budget est compris entre 300 et 1000 euros')
    end

    scenario('Healthcaring') do
      page.find('tr', text: 'Trouver où se soigner près de chez soi').click_link('Afficher')

      expect(page).to have_content("Il n'est pas encore possible de définir un public cible")
      expect(page).to have_content('pour une offre de service dont la thématique est santé')
    end
  end
end
