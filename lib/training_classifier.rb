# encoding: utf-8
# frozen_string_literal: true

require 'rubygems'
require 'bundler'
Bundler.setup(:default)

require 'ai4r'

module TrainingClassifier
  extend self

  def run
    attributes = %w(knowledge age status handicap continuation degree experience)

    training = [
      [0, '16-25', 'employee', 0, 1, '<4', 0, 'espace metier'],
      [0, '16-25', 'employee', 0, 0, '<4', 0, 'espace metier']
    ]

    dec_tree = DecisionTree::ID3Tree.new(
      attributes,
      training,
      'espace metier',
      knowledge: :discrete,
      age: :continuous,
      status: :discrete,
      handicap: :discrete,
      continuation: :discrete,
      degree: :continuous,
      experience: :discrete
    )

    dec_tree.train

    # test = [0, '16-25', 'employee', 0, 0, '<4', 0, 'espace metier']
    decision = dec_tree.predict(test)
    puts "Predicted: #{decision} ... True decision: #{test.last}"
  end
end

TrainingClassifier.run
