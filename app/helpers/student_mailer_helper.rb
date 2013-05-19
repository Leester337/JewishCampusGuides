module StudentMailerHelper
  def printEducation(edu)
  	str = ""
    edu.each do |sch|
		str = str + sch.school.school_type + ": " + sch.school.name + " - " + sch.year.to_s + "\n "
	end
	return str
  end

  def printInterests(interest)
  	str = ""
	@student.interested_in.each do |int|
		str = str + int.interest.name + " - " + int.interest.category
	end 
	return str
  end
end
