# encoding: utf-8
# frozen_string_literal: true

#
# Class TargetPublicDecorator provides a presenter for {TargetPublic}.
#
# @author Mauko Quiroga <mauko.quiroga@data.gouv.fr>
#
class TargetPublicDecorator < ApplicationDecorator
  def message(association)
    send("#{association}_message")
  end

  private

  def everybody_message
    internationalise('everybody')
  end

  def targeted_message
    internationalise('targeted')
  end

  def working_statuses_message
    internationalise('working_statuses', target_public: discrete_to_sentence(working_statuses))
  end

  def engagements_message
    internationalise('engagements', target_public: discrete_to_sentence(engagements))
  end

  def working_durations_message
    internationalise('working_durations', target_public: discrete_to_sentence(working_durations))
  end

  def working_age_message
    internationalise('working_age', minimum: working_age.minimum, maximum: working_age.maximum)
  end

  def last_classes_message
    internationalise('last_classes', target_public: discrete_to_sentence(last_classes))
  end

  def experiences_message
    internationalise('experiences', target_public: boolean_to_sentence(experiences))
  end

  def pole_emplois_message
    internationalise('pole_emplois', target_public: boolean_to_sentence(pole_emplois))
  end

  def mission_locales_message
    internationalise('mission_locales', target_public: boolean_to_sentence(mission_locales))
  end

  def cap_emplois_message
    internationalise('experiences', target_public: boolean_to_sentence(experiences))
  end

  def apecs_message
    internationalise('apecs', target_public: boolean_to_sentence(apecs))
  end

  def handicaps_message
    internationalise('handicaps', target_public: boolean_to_sentence(handicaps))
  end

  def awarenesses_message
    internationalise('awarenesses', target_public: discrete_to_sentence(awarenesses))
  end

  def housing_statuses_message
    internationalise('housing_statuses', target_public: discrete_to_sentence(housing_statuses))
  end

  def housing_durations_message
    internationalise('housing_durations', target_public: discrete_to_sentence(housing_durations))
  end

  def housing_age_message
    internationalise('housing_age', minimum: housing_age.minimum, maximum: housing_age.maximum)
  end

  def resource_message
    internationalise('resource', minimum: resource.minimum, maximum: resource.maximum)
  end

  def coming_soon_message
    internationalise('coming_soon', social_right: service_offering.social_right_name.downcase)
  end

  def discrete_to_sentence(collection)
    collection
      .map(&:name)
      .map(&:downcase)
      .to_sentence(two_words_connector: ' ou ', last_word_connector: ' ou ')
  end

  def boolean_to_sentence(collection)
    collection
      .map(&:value)
      .map(&:to_s)
      .map { |value| I18n.t(value) }
      .map(&:downcase)
      .to_sentence(two_words_connector: ' ou ')
  end

  def internationalise(key, target_public: nil, **kargs)
    I18n.t("activerecord.messages.target_public.#{key}", target_public: target_public, **kargs)
  end
end
