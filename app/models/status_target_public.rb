class StatusTargetPublic < ActiveRecord::Base
  belongs_to :target_public

  belongs_to :status
end
