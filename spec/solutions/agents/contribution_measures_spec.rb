# encoding: utf-8
# frozen_string_literal: true

situation %(
  Quand les acteurs interagissent entre eux via la Boussole,
  Ils veulent pouvoir gérer les mesures mobilisables par leurs structures,
  Ils veulent pouvoir consulter celles d'autres acteurs,
  Ils veulent pouvoir faire une simulation locale de mesures mobilisables,
  Pour pouvoir pallier le cloisonnement professionnel,
  Pour mieux valoriser mon travail tout en collaborant avec mes pairs,
  Pour me sentir plus accompli·e dans ma mission de service public,
  Et pour co-construire une offre de service territoriale.
) do
  # There's one social right
  given!(:social_right) { create(:social_right, name: 'Formation') }

  # There's one public service
  given!(:public_service) { create(:public_service, title: 'Plate-forme de décrochage', social_rights: [social_right]) }

  # There's one measure
  given!(:measure) do
    create(
      :measure,
      title: 'Retour à la formation initiale',
      public_service: public_service,
      social_rights: [social_right]
    )
  end

  background do
    # The agent navigates towards the measures space
    visit('/agents')
    click_link('Dispositifs')
  end

  solution('Create a measure') do
    scenario do
      click_link('Ajouter un nouveau dispositif')

      within('.profile-form') do
        select('Plate-forme de décrochage', from: 'Acteur')
        fill_in('Nom', with: 'Droit à la nouvelle chance - capital formation')
        fill_in('Description', with: 'Droit à la nouvelle chance : : tout jeune sorti sans diplôme blah blah…')
        fill_in('Site web', with: 'https://decrochage.jeunes.gouv.fr')
        select('Formation', from: 'Thématiques')

        click_button('Créer')
      end

      expect(page).to have_content('Le dispositif a été créé avec succès')
    end
  end

  solution('List all measures') do
    scenario { expect(page).to have_content('Retour à la formation initiale') }
    scenario { expect(page).to have_content('Plate-forme de décrochage') }
    scenario { expect(page).to have_content('Formation') }
  end

  solution('Sort measures by public service') do
    pending("Don't be lazy and get this solution done ASAP, users need it!")
  end

  solution('Sort measures by social right') do
    pending("Don't be lazy and get this solution done ASAP, users need it!")
  end

  solution('Take a look at a measure details') do
    scenario do
      click_link('Afficher')

      expect(page).to have_content('Plate-forme de décrochage')
      expect(page).to have_content('Retour à la formation initiale')
    end
  end

  solution('Edit a measure') do
    scenario do
      click_link('Modifier')

      within('.profile-form') do
        fill_in('Nom', with: 'Établissement public d’insertion pour l’emploi')

        click_button('Modifier')
      end

      expect(page).to have_content('Le dispositif a été modifié avec succès')
    end
  end

  solution('Delete a measure', js: true) do
    scenario do
      page.accept_confirm do
        click_link('Supprimer')
      end

      expect(page).to have_content('Le dispositif a été supprimé avec succès')
    end
  end
end
