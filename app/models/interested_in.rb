class InterestedIn < ActiveRecord::Base
  belongs_to :prospective_student
  belongs_to :interest
  # attr_accessible :title, :body
end
