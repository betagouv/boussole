# encoding: utf-8
# frozen_string_literal: true

require 'rubygems'
require 'bundler'
Bundler.setup(:default)

require 'ai4r'

module TrainingClassifier
  extend self

  def run
    train_file = Rails.root.join('lib', 'train.csv')
    train_set  = Ai4r::Data::DataSet.new.load_csv_with_labels(train_file)

    test_file  = Rails.root.join('lib', 'test.csv')
    test_set   = Ai4r::Data::DataSet.new.load_csv(test_file)

    id3 = Ai4r::Classifiers::ID3.new.build(train_set)

    test_set.data_items.map { |item| id3.eval(item) rescue nil }
  end
end

TrainingClassifier.run
