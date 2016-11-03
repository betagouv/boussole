# encoding: utf-8
# frozen_string_literal: true

namespace(:gemnasium) do
  desc('Gemfile autoupdate')
  task(autoupdate: :environment) do
    system("gemnasium --token #{ENV['GEMNASIUM_TOKEN']} autoupdate run")
  end
end
