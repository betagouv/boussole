# encoding: utf-8
# frozen_string_literal: true

# :bd stands for "Boussole de droits"
global_events_prefix(:bd)

# Starting date for data entries
'2016-11-07'.tap do |starting_date|
  version 1, starting_date do
    category :jeunes do
      event :visits_landing,    starting_date, "L'usager·ère arrive à la Boussole"
      event :starts_form,       starting_date, "L'usager·ère commence à remplir le formulaire"
      event :finishes_form,     starting_date, "L'usager·ère finit le formulaire et arrive à la page de résultats"
      event :discovers_service, starting_date, "L'usager·ère est intéressé·e (ou curieux·ieuse) par un service"
      event :activates_service, starting_date, "L'usager·ère laisse ses coordonnées pour être rappelé·e"
    end
  end
end
