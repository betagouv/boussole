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
    # I'm in the « agents » page
    visit('/agents')

    # Go to the « acteurs » page
    click_link('Acteur')
  end

  xsolution 'Create my agent profile'
  xsolution 'Edit my agent profile'

  solution 'Create a public services' do
    scenario 'with valid information' do
      # YOLO
      expect(page).to have_content('Acteur')
    end
  end

  xsolution 'List all public services'
  xsolution 'Edit a public service'
end
