class StudentMailer < ActionMailer::Base
  helper StudentMailerHelper
  default from: "jewishcampusguides@gmail.com"

  def send_student(student, college_rep)
  	@student = student
  	mail(:to => college_rep, :subject => "A prospective student is reaching out to you!")
  end
end
