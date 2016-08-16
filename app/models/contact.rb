# encoding: utf-8
# frozen_string_literal: true
#
# TODO: Add documentation.
#
# == Schema Information
#
# Table name: contacts
#
#  id         :integer          not null, primary key
#  email      :string
#  phone      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Contact < ApplicationRecord
  #
  # @!attribute [rw] email_or_phone
  #   @return [String] Email or phone the user wants to be contacted with.
  attr_accessor :email_or_phone
end
