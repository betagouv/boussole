# encoding: utf-8
# frozen_string_literal: true

#
# Module Admin provides global configuration to models using RailsAdmin
#
module Admin
  extend ActiveSupport::Concern

  included do
    rails_admin do
      list do
        exclude_fields(:slug, :created_at)

        configure(:updated_at) do
          strftime_format('%d-%m-%Y')
        end
      end

      create do
        exclude_fields(:slug)
      end

      edit do
        exclude_fields(:slug)
      end
    end
  end
end
