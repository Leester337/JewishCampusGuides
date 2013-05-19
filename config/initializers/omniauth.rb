OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, ENV['FACEBOOK_APP_ID'], ENV['FACEBOOK_SECRET'], 
  	:scope => 'email,user_about_me,user_education_history,user_hometown,user_interests,user_location', :display => 'popup'

end