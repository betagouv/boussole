# encoding: utf-8
# frozen_string_literal: true

#
# Class WorkingStatus corresponds to the criterium {WorkingStatus}, i.e. the
# status of a<tt>usager</tt>to which a service offering (with a <tt>Working</tt>
# {SocialRight}) can correspond.
#
# It is a criterium used to define the {TargetPublic}.
#
# @author Alexia Rey <alexia.rey@data.gouv.fr>
#
class WorkingStatus < ActiveRecord::Base
  include ReadOnly
  include HasManyCriterium
  include DiscreteCriterium
end
