class SessionsController < ApplicationController
  def create
    user = ProspectiveStudent.from_omniauth(env["omniauth.auth"])
    session[:user_id] = user.id
    redirect_to session[:collegeURL]
  end

  def destroy
	  session[:user_id] = nil
	  redirect_to session[:collegeURL]
  end
end