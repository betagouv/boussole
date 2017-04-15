# encoding: utf-8
# frozen_string_literal: true

#
# Class Apec corresponds to the criterium {Apec}, i.e. whether a <tt>usager</tt>
# is registered to the Apec or not (yes or no).
#
# It is a criterium used to defined the {TargetPublic}.
#
# @author Alexia Rey <alexia.rey@data.gouv.fr>
#
class Apec < ActiveRecord::Base
  include ReadOnly
  include Criterium
  include BooleanCriterium
end
