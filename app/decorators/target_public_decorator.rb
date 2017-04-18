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
    internationalise('working_statuses', target_public: list_to_sentence(working_statuses, :name))
  end

  def list_to_sentence(collection, attribute)
    collection
      .map(&attribute)
      .map(&:downcase)
      .to_sentence(two_words_connector: ' ou ', last_word_connector: ' ou ')
  end

  def internationalise(key, target_public: nil)
    I18n.t("activerecord.messages.target_public.#{key}", target_public: target_public)
  end
end
