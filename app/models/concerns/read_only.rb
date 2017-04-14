# encoding: utf-8
# frozen_string_literal: true

#
# Module ReadOnly prevents read-only records from being deleted.
#
# @author Mauko Quiroga <mauko.quiroga@data.gouv.fr>
#
module ReadOnly
  extend ActiveSupport::Concern

  included do
    before_destroy { raise ActiveRecord::ReadOnlyRecord }
    attr_readonly :name
  end
end
