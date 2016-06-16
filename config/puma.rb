# encoding: utf-8
# frozen_string_literal: true

workers Integer(ENV['WEB_CONCURRENCY'] || 2)
min_threads = Integer(ENV['MIN_THREADS'] || 5)
max_threads = Integer(ENV['MAX_THREADS'] || 5)
threads min_threads, max_threads

preload_app!

rackup      DefaultRackup
port        ENV['PORT']     || 5000
environment ENV['RACK_ENV'] || 'development'

on_worker_boot do
  ActiveRecord::Base.establish_connection
end
