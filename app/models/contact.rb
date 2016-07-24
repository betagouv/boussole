# encoding: utf-8
# frozen_string_literal: true
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
class Contact < ActiveRecord::Base
  attr_accessor :email_or_phone
end