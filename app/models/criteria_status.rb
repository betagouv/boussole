# #
# == Schema Information
# Schema version: 20170412152918
#
# Table name: criteria_statuses
#
# *criterium_id*:: <tt>integer, not null</tt>
# *status_id*::    <tt>integer, not null</tt>
#
# Indexes
#
#  index_criteria_statuses_on_criterium_id  (criterium_id)
#  index_criteria_statuses_on_status_id     (status_id)
#--
# == Schema Information End
#++
# #

class CriteriaStatus < ActiveRecord::Base
  belongs_to :criterium

  belongs_to :status
end
