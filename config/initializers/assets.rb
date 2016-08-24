# encoding: utf-8
# frozen_string_literal: true

# Be sure to restart your server when you modify this file.

# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.version = '1.0'

# Add additional assets to the asset load path
Rails.root.join('vendor', 'assets', 'components').to_s.tap do |components|
  Rails.application.config.sass.load_paths << components
  Rails.application.config.assets.paths    << components
end

# Precompile additional assets.
# application.js, application.css, and all non-JS/CSS in app/assets folder are already added.
Rails.application.config.assets.precompile << /\.(?:svg|eot|woff|ttf)$/
Rails.application.config.assets.precompile << %r{font-awesome/fonts/[\w-]+\.(?:eot|svg|ttf|woff2?)$}
Rails.application.config.assets.precompile << %r{open-sans/fonts/[\w-]+/[\w-]+\.(?:eot|svg|ttf|woff?)$}

# Minimum Sass number precision required by bootstrap-sass
Sass::Script::Value::Number.precision = [8, ::Sass::Script::Value::Number.precision].max
