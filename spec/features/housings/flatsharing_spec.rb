# encoding: utf-8
# frozen_string_literal: true

feature 'Find a flatsharing solution' do
  background { visit('/') }

  scenario %(
    Quand Zoe, 18 ans, bachelière, qui va bientôt commencer ses études,
    Veut trouver un logement en colocation pour la rentrée,
    Elle veut savoir quels sites d'internet proposent d'offres de colocation,
    Elle veut savoir qui peut l'orienter dans sa recherche,
    Elle veut entrer en contact avec quelqu'un qui puisse l'aider dans sa recherche,
    Ses parents veulent connaître les aides disponibles pour leur situation,
    Pour pouvoir gagner du temps,
    Et trouver un logement rapidement.
  ) do
    click_link('Commencer !')

    # Duration:
    select('1 an', from: 'Pour combien de temps ?')

    # Desired location:
    select('Reims', from: 'Où souhaites-tu te loger ?')

    # Budget:
    fill_in('Quel est ton budget mensuel pour te loger (€) ?', with: 300)

    # Submit
    click_button('Continuer')

    # Current status:
    select('Lycéen·ne', from: "Quelle est ta situation aujourd'hui ?")

    # Next status:
    check('Seras-tu étudiant·e à la rentrée ?', match: :first)

    # Current location:
    # Thinks it's not relevant.
    # Doesn't answer.

    # Age
    fill_in('Tu as quel âge ?', with: 18)

    # Submit
    click_button('Continuer')

    # TODO: Add flatsharing information.
    expect(page).to(have_content(/coloc/i))
    expect(page).to(have_content(/crous/i))
    expect(page).to(have_content(/clé/i))
    expect(page).to(have_content(/caf/i))
    expect(page).to(have_content(/contact/i))

    # TODO: Make sure we give an answer to all of Zoe's and her parents' motivations.
  end
end
