# encoding: utf-8
# frozen_string_literal: true

class TargetPublicStatus < ActiveRecord::Base
  belongs_to :target_public
  belongs_to :status
end
