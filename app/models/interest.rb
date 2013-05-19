class Interest < ActiveRecord::Base
  has_many :interested_in
  has_many :prospective_students, :through => :interested_in
  attr_accessible :category, :fid, :name
end
