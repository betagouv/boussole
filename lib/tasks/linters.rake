# encoding: utf-8
# frozen_string_literal: true

desc 'Run all linters for this project.'
multitask linters: %i(haml_lint scss_lint inch rubocop)
