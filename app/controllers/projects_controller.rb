class ProjectsController < ApplicationController
  # before_action :set_project, only: [:show, :edit, :update]

  # GET /projects/1
  def show
    @project = Project.find(params[:id])

    @service =
    if @project.status.in?(['Sans activité', 'Étudiant·e (décrochage)', 'Lycéen·ne – collégien·ne (décrochage)'])
      {
        name: 'Pôle emploi',
        address: '67, rue du Mont d’Arène, 51100 Reims',
        email: 'ape.51436@pole-emploi.fr',
        phone: '03 26 77 17 67',
        url: 'http://www.pole-emploi.fr/annuaire/reims-mont-d-arene-51436',
        services: [
          "Valider ton projet professionnel",
          "T'inscrire dans une formation",
          "T'informer sur les aides au financement de la formation"
        ]
      }
    elsif @project.status.in?(['Étudiant·e', 'Lycéen·ne – collégien·ne'])
      {
        name: "Centre d'information et d'orientation",
        address: '36 Rue Boulard, 51100 Reims',
        email: '',
        phone: '03 26 88 22 32',
        url: '',
        services: [
          "T'informer sur les métiers, les filières",
          "T'orienter dans tes études",
          "Valider ton projet d'études"
        ]
      }
    else
      {
        name: 'Espaces métiers Reims',
        address: '9 rue Noël, 51100 Reims',
        email: 'reims@espacesmetiers.org',
        phone: '03 26 79 11 20',
        url: 'http://www.espacesmetiers-champagneardenne.org/',
        services: [
          "Valider ton projet de formation",
          "Etre accompagné pour choisir une formation",
          "T'inscrire dans une formation "
        ]
      }
    end
  end

  # POST /projects
  def create
    @project = Project.new
    @project.save(validate: false)
    redirect_to(project_step_path(@project, Project::STEPS.first))
  end
end
