require 'rails_admin/config/actions'
require 'rails_admin/config/actions/base'
 
module RailsAdminUpdateEvents
end
 
module RailsAdmin
  module Config
    module Actions
      class UpdateEvents < RailsAdmin::Config::Actions::Base

      	register_instance_option :root? do
          true
        end

        register_instance_option :i18n_key do
          :updateEventsKey
        end

        register_instance_option :link_icon do
          "icon-calendar"
        end 

        register_instance_option :http_methods do
          [:get,:post]
        end

        register_instance_option :controller do
          Proc.new do
          	render "update_events"
          end
      	end
        
      end
    end
  end
end