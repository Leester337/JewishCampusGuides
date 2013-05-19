class Schooled < ActiveRecord::Base
  belongs_to :prospective_student
  belongs_to :school
  attr_accessible :concentration, :degree, :year
end
