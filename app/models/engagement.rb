# encoding: utf-8
# frozen_string_literal: true

#
# Class Engagement corresponds to the criterium {Engagement}, i.e. the time a
# <tt>usager</tt> is willing to devote to a job.
#
# It is a criterium used to define the {Target Public}.
#
# @author Alexia Rey <alexia.rey@data.gouv.fr>
#
class Engagement < ActiveRecord::Base
  include ReadOnly
  include DiscreteCriterium

  has_many :target_public_engagements,
           inverse_of: :engagement,
           dependent: :destroy

  has_many :target_publics,
           through: :target_public_engagements
end
