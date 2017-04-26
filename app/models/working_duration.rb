# encoding: utf-8
# frozen_string_literal: true

#
# Class WorkingDuration corresponds to the criterium {WorkingDuration}, i.e. is
# the desired duration of a job to which a {ServiceOffering} (with a <tt>Working</tt>tt>
# {SocialRight}) can correspond.
#
# It is a criterium used to defined the {TargetPublic}.
#
# @author Alexia Rey <alexia.rey@data.gouv.fr>
#
class WorkingDuration < ActiveRecord::Base
  include ReadOnly
  include HasManyCriterium
  include DiscreteCriterium
end
