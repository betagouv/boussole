# encoding: utf-8
# frozen_string_literal: true

class Status < ActiveRecord::Base
  include ReadOnly
  include Criterium
  include DiscreteCriterium
end
