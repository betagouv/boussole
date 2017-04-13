# encoding: utf-8
# frozen_string_literal: true

situation %(
  Quand les acteurs interagissent entre eux via la Boussole,
  Ils veulent pouvoir gérer l'offre de service de leurs structures,
  Ils veulent pouvoir consulter celles d'autres acteurs,
  Pour orienter les jeunes vers leurs services prioritaires,
  Pour cibler et toucher de nouveaux publics,
  Et pour co-construire une offre de service territoriale.
) do
  # There's one social right
  given!(:social_right) { create(:social_right, name: 'Logement') }

  # There's one public service
  given!(:public_service) do
    create(
      :public_service,
      title: 'Services Intégrés de l’Accueil et de l’Orientation'
    )
  end

  # There's one service offering
  given!(:service_offering) do
    create(
      :service_offering,
      title: "Trouver une solution de logement d'urgence",
      public_service: public_service,
      social_right: social_right
    )
  end

  background do
    # The agent is at the service offering's space
    visit('/agents/service_offerings')
  end

  solution('Create a service offering') do
    scenario 'with valid inofrmation' do
      click_link('Ajouter une nouvelle offre de service')

      within('.profile-form') do
        select('Services Intégrés de l’Accueil et de l’Orientation', from: 'Acteur')
        fill_in('Nom', with: 'Découvrir les solutions logement sur ton territoire')
        fill_in('Description', with: 'Découvrir les solutions logement sur ton territoire')
        fill_in('Adresse', with: '50 rue de la Dalle, 71234 Paname')
        fill_in('Email', with: 'logement@acteur.fr')
        fill_in('Téléphone', with: '01 23 45 67 89')
        fill_in('Site web', with: 'https://logement.jeunes.gouv.fr')
        fill_in('Délai garanti de réponse', with: 22)
        select('Logement', from: 'Thématique')

        click_button('Créer')
      end

      expect(page).to have_content('Offre de service créé·e avec succès')
    end

    scenario 'without valid information' do
      click_link('Ajouter une nouvelle offre de service')

      within('.profile-form') do
        fill_in('Délai garanti de réponse', with: 'sept jours')
        click_button('Créer')
      end

      expect(page).to have_content('Flûte ! Manque-t-il quelque chose ?')
      expect(page).to have_content("n'est pas un nombre")
    end
  end

  solution('List all service offerings') do
    scenario do
      expect(page).to have_content("Trouver une solution de logement d'urgence")
      expect(page).to have_content('Services Intégrés de l’Accueil et de l’Orientation')
      expect(page).to have_content('Logement')
    end
  end

  solution('Sort service offerings by public service') do
    pending("Don't be lazy and get this solution done ASAP, users need it!")
  end

  solution('Sort service offerings by social right') do
    pending("Don't be lazy and get this solution done ASAP, users need it!")
  end

  solution('Take a look at a service offering details') do
    scenario do
      click_link('Afficher')

      expect(page).to have_content("Trouver une solution de logement d'urgence")
      expect(page).to have_content('trouver-une-solution-de-logement-d-urgence')
      expect(page).to have_content('Services Intégrés de l’Accueil et de l’Orientation')
    end
  end

  solution('Edit a service offering') do
    scenario do
      click_link('Modifier')

      within('.profile-form') do
        fill_in('Nom', with: 'Cours de Zumba')
        click_button('Modifier')
      end

      expect(page).to have_content('Offre de service modifié·e avec succès')
      expect(page).to have_content('trouver-une-solution-de-logement-d-urgence')
    end
  end

  solution('Delete a service offering', js: true) do
    scenario do
      page.accept_confirm { click_link('Supprimer') }
      expect(page).to have_content('Offre de service supprimé·e avec succès')
    end
  end
end
