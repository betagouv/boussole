# #
# == Schema Information
# Schema version: 20170412152918
#
# Table name: statuses
#
# *id*::         <tt>integer, not null, primary key</tt>
# *value*::      <tt>string</tt>
# *created_at*:: <tt>datetime, not null</tt>
# *updated_at*:: <tt>datetime, not null</tt>
#--
# == Schema Information End
#++
# #

class Status < ActiveRecord::Base
  has_many :criteria_statuses

  has_many :criteria, through: :criteria_statuses

  validates :value,
  presence: true
end
