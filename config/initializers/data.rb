# encoding: utf-8
# frozen_string_literal: true

# Load static domain values and store them into frozen constants.
Dir.glob(Rails.root.join('config', 'data', '*.yml')) do |filepath|
  data        = YAML.load(File.read(filepath))
  key, values = data.first

  Object.send(:const_set, key.upcase, values.freeze)
end
