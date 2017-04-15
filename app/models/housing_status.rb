# encoding: utf-8
# frozen_string_literal: true

#
# Class HousingStatus corresponds to the criterium {HousingStatus}, i.e. the
# status of a<tt>usager</tt>to which a service offering (with a <tt>housing</tt>
# {SocialRight}) can correspond.
#
# It is a criterium used to define the {TargetPublic}.
#
# @author Alexia Rey <alexia.rey@data.gouv.fr>
#
class HousingStatus < ActiveRecord::Base
  include ReadOnly
  include Criterium
  include DiscreteCriterium
end
