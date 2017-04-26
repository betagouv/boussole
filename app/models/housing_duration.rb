# encoding: utf-8
# frozen_string_literal: true

#
# Class HousingDuration corresponds to the criterium {HousingDuration}, i.e. is
# the desired duration of a job to which a {ServiceOffering} (with a <tt>housing</tt>tt>
# {SocialRight}) can correspond.
#
# It is a criterium used to defined the {TargetPublic}.
#
# @author Alexia Rey <alexia.rey@data.gouv.fr>
#
class HousingDuration < ActiveRecord::Base
  include ReadOnly
  include HasManyCriterium
  include DiscreteCriterium
end
