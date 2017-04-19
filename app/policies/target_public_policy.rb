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

  def engagements?
    target_public.engagements.any?
  end

  def working_durations?
    target_public.working_durations.any?
  end

  def working_age?
    target_public.working_age.any?
  end

  def last_classes?
    target_public.last_classes.any?
  end

  def experiences?
    target_public.experiences.any?
  end

  def pole_emplois?
    target_public.pole_emplois.any?
  end

  def mission_locales?
    target_public.mission_locales.any?
  end

  def cap_emplois?
    target_public.cap_emplois.any?
  end

  def apecs?
    target_public.apecs.any?
  end

  def handicaps?
    target_public.handicaps.any?
  end

  def awarenesses?
    target_public.awarenesses.any?
  end

  def housing_statuses?
    target_public.housing_statuses.any?
  end

  def housing_durations?
    target_public.housing_durations.any?
  end

  def housing_age?
    target_public.housing_age.any?
  end

  def resource?
    target_public.resource.any?
  end
end
