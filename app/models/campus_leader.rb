class CampusLeader < ActiveRecord::Base
  belongs_to :organization
  attr_accessible :bio, :email, :hometown, :link, :name, :picture, :quote, :significant_other, :organization_id, :fid
end
