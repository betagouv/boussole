# encoding: utf-8
# frozen_string_literal: true

situation %(
  Quand les acteurs interagissent entre eux via la Boussole,
  Ils veulent pouvoir gérer leurs cordonnées,
  Ils veulent pouvoir gérer les cordonnées de leurs structures,
  Ils veulent pouvoir gérer les compétences de leurs structures,
  Ils veulent pouvoir consulter celles d'autres acteurs,
  Pour pouvoir pallier le cloisonnement professionnel,
  Pour pouvoir connaître la communauté d'acteurs locale,
  Et pour connaître d'autres acteurs pouvant les aider dans des cas complexes.
) do
  # There's one social right
  given!(:social_right) { create(:social_right, name: 'Emploi') }

  # There's one public service
  given!(:public_service) { create(:public_service, title: 'Pôle emploi', social_rights: [social_right]) }

  background do
    # The agent is using Boussole - Cœur d'Essonne
    allow(Rails.application.config).to receive(:rhizome) { 'essonne' }

    # The agent is at the public service's space
    visit('/agents/public_services')
  end

  solution('Create a public service') do
    scenario 'with valid information' do
      click_link('Ajouter un nouvel acteur')

      within('.profile-form') do
        fill_in('Nom', with: 'Plate-forme de décrochage')
        fill_in('Description', with: "Les plates-formes de suivi et d'appui aux décrocheurs blah blah")
        fill_in('Adresse', with: '50 rue de la Dalle, 71234 Paname')
        fill_in('Email', with: 'decrochage@acteur.fr')
        fill_in('Téléphone', with: '01 23 45 67 89')
        fill_in('Site web', with: 'https://decrochage.jeunes.gouv.fr')
        fill_in('Délai garanti de réponse', with: 22)
        select('Emploi', from: 'Thématiques')
        select('Aougny', from: 'Compétence territoriale')

        click_button('Créer')
      end

      expect(page).to have_content('Acteur créé·e avec succès')
    end

    scenario 'without valid information' do
      click_link('Ajouter un nouvel acteur')

      within('.profile-form') do
        fill_in('Délai garanti de réponse', with: 'sept jours')
        click_button('Créer')
      end

      expect(page).to have_content('Flûte ! Manque-t-il quelque chose ?')
      expect(page).to have_content("n'est pas un nombre")
    end
  end

  solution('List all public services') do
    scenario do
      expect(page).to have_content("Liste d'acteurs à Cœur d'Essonne")
      expect(page).to have_content('Pôle emploi')
      expect(page).to have_content('Emploi')
    end
  end

  solution('Sort public services by social right') do
    pending("Don't be lazy and get this solution done ASAP, users need it!")
  end

  solution('Take a look at a public service details') do
    scenario do
      click_link('Afficher')

      expect(page).to have_content('Pôle emploi')
      expect(page).to have_content('pole-emploi')
    end
  end

  solution('Edit a public service') do
    scenario do
      click_link('Modifier')

      within('.profile-form') do
        fill_in('Nom', with: 'Cap emploi')
        click_button('Modifier')
      end

      expect(page).to have_content('Acteur modifié·e avec succès')
      expect(page).to have_content('pole-emploi')
    end
  end

  solution('Delete a public service', js: true) do
    scenario do
      page.accept_confirm { click_link('Supprimer') }
      expect(page).to have_content('Acteur supprimé·e avec succès')
    end
  end
end
