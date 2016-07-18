# encoding: utf-8
# frozen_string_literal: true

class Contact < ActiveRecord::Base
  attr_accessor :email_or_phone
end
