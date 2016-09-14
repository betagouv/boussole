# encoding: utf-8
# frozen_string_literal: true

#
# Class ApplicationRecord provides "a single point of entry for all the
# customizations and extensions needed for an application".
#
# @see    http://blog.bigbinary.com/2015/12/28/application-record-in-rails-5.html
# @note   Rails 5 default
#
class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true
end
