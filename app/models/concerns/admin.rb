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
        exclude_fields :created_at
      end
    end
  end
end
