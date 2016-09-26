# encoding: utf-8
# frozen_string_literal: true

#
# @deprecated Worthless.
#
# TODO: Get rid of (use a {Struct} for sending contact emails).
#

#
# == Schema Information
# Schema version: 20160914121308
#
# Table name: contacts
#
# *id*::         <tt>integer, not null, primary key</tt>
# *email*::      <tt>string</tt>
# *phone*::      <tt>string</tt>
# *created_at*:: <tt>datetime, not null</tt>
# *updated_at*:: <tt>datetime, not null</tt>
#--
# == Schema Information End
#++
#
class Contact < ApplicationRecord
  #
  # @!attribute [rw] email_or_phone
  # @return [String] Email or phone the user wants to be contacted with.
  #
  attr_accessor :email_or_phone
end
