# encoding: utf-8
# frozen_string_literal: true

namespace :db do
  desc 'Dumps the database to db/boussole.dump'
  task dump: :environment do
    with_config do |host, db, user|
      sh(
        'pg_dump',
        "--host=#{host}",
        "--username=#{user}",
        '--verbose',
        '--clean',
        '--no-owner',
        '--no-acl',
        '--format=c',
        "--file=#{Rails.root}/db/latest.dump",
        db
      )
    end
  end

  desc 'Restores the database dump at db/boussole.dump'
  task restore: :environment do
    Rake::Task['db:drop'].invoke
    Rake::Task['db:create'].invoke

    with_config do |host, db, user|
      sh(
        'pg_restore',
        "--host=#{host}",
        "--username=#{user}",
        '--verbose',
        '--clean',
        '--no-owner',
        '--no-acl',
        "--dbname=#{db}",
        "#{Rails.root}/db/latest.dump"
      )
    end
  end

  private

  def with_config
    yield \
      ActiveRecord::Base.connection_config[:host],
      ActiveRecord::Base.connection_config[:database],
      ActiveRecord::Base.connection_config[:username]
  end
end
