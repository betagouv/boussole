# encoding: utf-8
# frozen_string_literal: true

class TargetPublicStatus < ActiveRecord::Base
  belongs_to :target_public,
             inverse_of: :target_public_status

  belongs_to :status,
             inverse_of: :target_public_status
end
