class College < ActiveRecord::Base
  extend FriendlyId
  friendly_id :nickname
  has_many :event_creator
  attr_accessible :israelStudyAbroad, :gcalURL, :imageURL, :nickname, :jewishCourses, :jewishMajor, :jewishMinor, :jewishPopGrad, :jewishPopUndergrad, :name, :popGrad, :popUndergrad, :programsOfStudy, :studyAbroad, :uniqueCourses
	
  
end
