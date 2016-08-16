# encoding: utf-8
# frozen_string_literal: true

revision =
  # Capistrano & friends
  if File.exist?(Rails.root.join('REVISION'))
    `cat #{Rails.root.join('REVISION')}`
  # Heroku
  elsif File.exist?(Rails.root.join('.source_version'))
    `cat #{Rails.root.join('.source_version')}`
  # Whatever else
  else
    `git rev-parse HEAD`
  end

REVISION = revision.chomp.send(:[], 0..10).freeze
