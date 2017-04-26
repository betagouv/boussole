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
  include HasManyCriterium
  include DiscreteCriterium
end
