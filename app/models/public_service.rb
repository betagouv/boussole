# encoding: utf-8
# frozen_string_literal: true
# == Schema Information
#
# Table name: public_services
#
#  id             :integer          not null, primary key
#  title          :string
#  description    :text
#  postal_address :string
#  email          :string
#  phone          :string
#  url            :string
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#
class PublicService < ActiveRecord::Base
  has_many :service_offerings
  has_many :measures

  validates :title,
            :description,
            :postal_address,
            presence: true
end
