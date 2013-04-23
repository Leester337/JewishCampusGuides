# (create oauth2 tokens from Google Console)
client_id = ""
client_secret = ""
# (paste the scope of the service you want here)
# e.g.: https://www.googleapis.com/auth/gan
scope = ""
 
 
 
 
# gem install oauth2
#require 'oauth2'
raise "Missing client_id variable" if client_id.to_s.empty?
raise "Missing client_secret variable" if client_secret.to_s.empty?
raise "Missing scope variable" if scope.to_s.empty?
 
redirect_uri = 'https://localhost/oauth2callback'
 
auth_client_obj = OAuth2::Client.new(client_id, client_secret, {:site => 'https://accounts.google.com', :authorize_url => "/o/oauth2/auth", :token_url => "/o/oauth2/token"})
 
# STEP 1
puts "1) Paste this URL into your browser where you are logged in to the relevant Google account\n\n"
puts auth_client_obj.auth_code.authorize_url(:scope => scope, :access_type => "offline", :redirect_uri => redirect_uri, :approval_prompt => 'force')
 
# STEP 2
puts "\n\n\n2) Accept the authorization request from Google in your browser:"
 
# STEP 3
puts "\n\n\n3) Google will redirect you to localhost, but just copy the code parameter out of the URL they redirect you to, paste it here and hit enter:\n"
code = gets.chomp.strip
 
 
access_token_obj = auth_client_obj.auth_code.get_token(code, { :redirect_uri => redirect_uri, :token_method => :post })
# STEP 4
puts "Token is: #{access_token_obj.token}"
puts "Refresh token is: #{access_token_obj.refresh_token}"
puts "\n\n\nNow you can make API requests with the following api_access_token_obj variable!\n"
puts "api_client_obj = OAuth2::Client.new(client_id, client_secret, {:site => 'https://www.googleapis.com'})"
puts "api_access_token_obj = OAuth2::AccessToken.new(api_client_obj, '#{access_token_obj.token}')"
puts "api_access_token_obj.get('some_relative_path_here') OR in your browser: http://www.googleapis.com/some_relative_path_here?access_token=#{access_token_obj.token}"
puts "\n\n... and when that access_token expires in 1 hour, use this to refresh it:\n"
puts "refresh_client_obj = OAuth2::Client.new(client_id, client_secret, {:site => 'https://accounts.google.com', :authorize_url => '/o/oauth2/auth', :token_url => '/o/oauth2/token'})"
puts "refresh_access_token_obj = OAuth2::AccessToken.new(refresh_client_obj, '#{access_token_obj.token}', {refresh_token: '#{access_token_obj.refresh_token}'})"
puts "refresh_access_token_obj.refresh!"