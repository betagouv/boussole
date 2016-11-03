# encoding: utf-8
# frozen_string_literal: true

guard :bundler do
  watch('Gemfile')
end

guard :bower do
  watch('bower.json')
end

guard :foreman do
  watch('Gemfile.lock')
  watch('app/models/feature.rb')
  watch(%r{^(config|lib)/.+\.rb$})
end

guard :rspec, cmd: 'bin/rspec' do
  watch(%r{^spec/.+_spec\.rb$})
  watch('spec/spec_helper.rb')                        { 'spec' }
  watch('spec/rails_helper.rb')                       { 'spec' }
  watch(%r{^spec/support/(.+)\.rb$})                  { 'spec' }
  watch(%r{^spec/factories/(.+)s\.rb$})               { |m| "spec/models/#{m[1]}_spec.rb" }

  # Rails
  watch(%r{^app/(.+)\.rb$})                           { |m| "spec/#{m[1]}_spec.rb" }
  watch(%r{^app/(.*)(\.erb|\.haml|\.slim)$})          { |m| "spec/#{m[1]}#{m[2]}_spec.rb" }
  watch(%r{^app/controllers/(.+)_(controller)\.rb$})  { |m| ["spec/routing/#{m[1]}_routing_spec.rb", "spec/#{m[2]}s/#{m[1]}_#{m[2]}_spec.rb", "spec/requests/#{m[1]}_spec.rb"] }
  watch('app/controllers/application_controller.rb')  { 'spec/controllers' }
  watch('config/routes.rb')                           { 'spec/routing' }
  watch(%r{^lib/(.+)\.rb$})                           { |m| "spec/lib/#{m[1]}_spec.rb" }
end

guard 'livereload' do
  watch(%r{app/views/.+\.(erb|haml|slim)$})
  watch(%r{app/helpers/.+\.rb})
  watch(%r{public/.+\.(css|js|html)})
  watch(%r{config/locales/.+\.yml})

  # Rails Assets Pipeline
  watch(%r{(app|vendor)(/assets/\w+/(.+\.(css|js|html|png|jpg))).*}) { |m| "/assets/#{m[3]}" }
end
