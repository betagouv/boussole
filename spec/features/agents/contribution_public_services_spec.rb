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
  background do
    create(:social_right, name: 'Emploi')
    visit('/agents')
    click_link('Acteur')
  end

  solution 'Create a public service' do
    scenario 'with valid information' do
      click_link('Ajouter un nouvel acteur')

      within('form') do
        fill_in('Nom', with: 'Plate-forme de décrochage')
        fill_in('Description', with: "Les plates-formes de suivi et d'appui aux décrocheurs blah blah")
        fill_in('Adresse', with: '50 rue de la Dalle, 71234 Paname')
        fill_in('Email', with: 'decrochage@acteur.fr')
        fill_in('Téléphone', with: '01 23 45 67 89')
        fill_in('Site web', with: 'https://decrochage.jeunes.gouv.fr')
        select('Emploi', from: 'Thématiques')

        click_button('Créer')
      end

      expect(page).to have_content("L'acteur a été crée avec succès")
    end
  end

  xsolution 'List all public services'
  xsolution 'Sort public services by social right'
  xsolution 'Take a look at a public service details'
  xsolution 'Edit a public service'
  xsolution 'Delete a public service'
end
