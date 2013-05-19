class EventCreatorsController < ApplicationController
	def organization_selection
		@organizations = Organization.where(:college_id => params[:college_id])
		render :partial => "event_creators/organizations", :object => @organizations
	end
end
