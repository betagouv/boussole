class AddSocialRightReferenceToServiceOfferings < ActiveRecord::Migration
  def change
    add_reference :service_offerings, :social_right, index: true, foreign_key: true
  end
end
