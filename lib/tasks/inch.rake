# encoding: utf-8
# frozen_string_literal: true
begin
  require 'inch/rake'

  Inch::Rake::Suggest.new('doc:suggest') do |suggest|
    suggest.args += %w(--all --pedantic)
  end
rescue LoadError
  task doc: :suggest do
    # no-op in environments where Inch is not installed
  end
end
