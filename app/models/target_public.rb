# #
# == Schema Information
# Schema version: 20170413142259
#
# Table name: target_publics
#
# *id*::                  <tt>integer, not null, primary key</tt>
# *created_at*::          <tt>datetime, not null</tt>
# *updated_at*::          <tt>datetime, not null</tt>
# *service_offering_id*:: <tt>integer</tt>
#--
# == Schema Information End
#++
# #

class TargetPublic < ActiveRecord::Base
  belongs_to :service_offering

  has_many :target_public_statuses

  has_many :statuses, through: :statuses_target_publics

  validates :service_offering_id,
            presence: true
end
