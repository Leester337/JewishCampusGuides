class College < ActiveRecord::Base
  extend FriendlyId
  friendly_id :nickname
  has_many :event_creator
  has_many :organization
  attr_accessible :israelStudyAbroad, :rep_email, :gcalURL, :imageURL, :nickname, :jewishCourses, :jewishMajor, :jewishMinor, :jewishPopGrad, :jewishPopUndergrad, :name, :popGrad, :popUndergrad, :programsOfStudy, :studyAbroad, :uniqueCourses
	
  rails_admin do

  	group :genAcademics do
  		label "General Academics"

	  	field :name do
	        label "College Name:"
	    end

	    field :nickname do
	        label "College Short Name:"
	    end

	    field :popUndergrad do
	        label "Number of Undergrad Students:"
	    end

	    field :popGrad do
	        label "Number of Grad Students:"
	    end

	    field :programsOfStudy do
	        label "Number of Programs of Study (i.e. majors):"
	    end

	    field :uniqueCourses do
	        label "Number of Unique Courses:"
	    end

	    field :studyAbroad do
	        label "Number of Study Abroad Programs:"
	    end

    end

    group :jewishAcademics do
    	label "Jewish Academics"

	    field :jewishPopUndergrad do
	        label "Number of Jewish Undergrad Students:"
	    end

	    field :jewishPopGrad do
        	label "Number of Jewish Grad Students:"
    	end

	    field :jewishMajor do
	        label "Jewish Major Available?"
	    end

	    field :jewishMinor do
	        label "Jewish Minor Available?"
	    end

	    field :jewishCourses do
        	label "Number of Jewish Related Courses:"
    	end

	  	field :israelStudyAbroad do
	        label "Number of Israel Study Abroad Programs:"
	    end
	end

	group :other do
		label "Other Data"

	    field :rep_email do
	        label "Representative Email Address:"
	    end

	    field :gcalURL do
	        label "URL of Embedded Google Calendar:"
	    end

	    field :imageURL do
	        label "URL of College Logo:"
	    end
	end

  end
end
