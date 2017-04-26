# encoding: utf-8
# frozen_string_literal: true

class TargetPublicPolicy
  attr_reader :target_public

  def initialize(_, target_public)
    @target_public = target_public
  end

  #
  # Tells whether or not a {TargetPublic} corresponds to every single user.
  # Practically, if no criterium is defined, a {ServiceOffering} will be considered
  # as for everybody.
  #
  # @return [Boolean] Is it for everybody or not?
  #
  def everybody?
    target_public.criteria.each do |criterium|
      association = target_public.public_send(criterium)
      break(false) if association.present? && association.any?
      next(true)
    end
  end

  #
  # Are we defining criteria for the second time onwards?
  #
  # @return [Boolean] Yes or no.
  #
  def define?
    target_public.criteria.present?
  end

  #
  # Are we defining criteria for the first time?
  #
  # @return [Boolean] Yes or no.
  #
  def define_first_time?
    everybody? && present?
  end

  def show?(association)
    update?(association) && target_public.public_send(association).any?
  end

  def update?(association)
    target_public.criteria.include?(association)
  end
end
