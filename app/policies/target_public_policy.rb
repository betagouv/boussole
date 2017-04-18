# encoding: utf-8
# frozen_string_literal: true

class TargetPublicPolicy
  attr_reader :target_public

  def initialize(_, target_public)
    @target_public = target_public
  end

  def everybody?
  end

  def working_statuses?
    target_public.working_statuses.any?
  end
end
