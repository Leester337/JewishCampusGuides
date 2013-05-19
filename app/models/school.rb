class School < ActiveRecord::Base
	has_many :schooled
	has_many :prospective_students, :through => :schooled
  attr_accessible :name, :school_type
end
