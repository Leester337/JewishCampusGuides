require'google/api_client'


module EventCreatorsHelper

=begin
	The first function to be called when updateEvents page is loaded. It sets the auth cookies
	from the post values and calls getFBEvents
=end
	def checkPosts
		if (params.has_key?(:fbAccessToken))
			cookies.signed['fbAccessToken'] = { :value => params[:fbAccessToken] }
		elsif (params.has_key?(:googleAccessToken))
			cookies.signed['googleAccessToken'] = { :value => params[:googleAccessToken], :expires => 1.year.from_now}
			cookies.signed['googleRefreshToken'] = { :value => params[:googleRefreshToken], :expires => 1.year.from_now }
		elsif (params.has_key?(:campusLeaderFacebookId))
			return createCampusLeader			
		end
		if (params.has_key?(:college) == false)
			return "Please select a college."
		end

		testGoogleAccess = testGoogle

		if (testGoogleAccess != nil)
			return testGoogleAccess
		end

		return getFBEvents
	end

=begin
	Creates a campus leader given the organization and facebook ID.
=end
	def createCampusLeader
		retval = ""
		fbGraph = getFbGraph

		query = params[:campusLeaderFacebookId] + 
				"?fields=id,name,email,bio,picture.width(300),link,hometown,significant_other,quotes"
		#query = "me"
		campusLeaderStats = fbGraph.get_object(query)
		#return campusLeaderStats
		leader = CampusLeader.where(:fid => campusLeaderStats['id']).first_or_initialize(
			:name => campusLeaderStats['name'],
			:link => campusLeaderStats['link'],
			:organization_id => params['organization_id']
			)
		leader.picture = campusLeaderStats['picture']['data']['url'] unless campusLeaderStats['picture'].nil?
		leader.bio = campusLeaderStats['bio']
		leader.email = campusLeaderStats['email']
		leader.hometown	= campusLeaderStats['hometown']['name'] unless campusLeaderStats['hometown'].nil?
		leader.significant_other = campusLeaderStats['significant_other']
		leader.quote = campusLeaderStats['quotes']

		leader.save


	end

=begin
	Deletes all the events of a given calendar so that we can test it again
=end

	def removeAllEvents
		EventCreator.all.collect {|c| if (c.college.nickname == params[:college]) then removeEvent c end}
	end

	def testGoogle
		client = getGoogleClient
		service = @client.discovered_api('calendar', 'v3')
		page_token = nil
		result = client.execute(:api_method => service.calendars.get,
                        :parameters => {'calendarId' => 'primary'})

		if (result.success? == false)
			return "Renew your Google Access Codes" + result.body
		else return nil
		end
	end

	def removeEvent(event_creator)
		client = getGoogleClient
		service = @client.discovered_api('calendar', 'v3')
		page_token = nil


		result = client.execute(:api_method => service.calendars.clear,
                        :parameters => {'calendarId' => event_creator.cal_id})
	end

=begin
	It calls importFB on each EventCreator of a selected college
=end
	def getFBEvents
		retval = ""
		if (cookies.signed['fbAccessToken'] == nil)
			return "fb Access not found";
		end

		names = []
		EventCreator.all.collect {|c| if (c.college.nickname == params[:college]) then importFb c end}

	end

=begin
	This retrieves the facebook events of an event_creator and calls createGCal on each event
=end
	def importFb(event_creator)
		begin 
			retval = ""
			fbGraph = getFbGraph
			time = Time.new
			query = event_creator.fb_id + 
				"/events?since=" + time.year.to_s + "-" + time.month.to_s + "-" + time.day.to_s + 
				"&fields=cover,picture.width(400),description,end_time,id,name,owner,privacy,start_time,ticket_uri,updated_time,venue,invited.summary(1)"
			creatorEvents = fbGraph.get_object(query)
			numloops = params[:loops].to_i
			while numloops != 0
				creatorEvents.each {|ev| retval = retval + saveOrUpdateEvent(ev, event_creator).to_s } # it's a subclass of Array
				
				if ((creatorEvents = creatorEvents.next_page) == nil)
					break
				end
				numloops = numloops - 1
			end
			return retval
		rescue Koala::Facebook::APIError => e
    		if e.message.include?("OAuthException")
		      Rails.logger.error "Facebook access token not valid for with #{e}"    
		    end
		    return "Your facebook token has expired :("
  		end
	end

	def saveOrUpdateEvent(ev, event_creator)

		if (ev['description'] == nil)
			ev.merge!("description" => "no description provided")
		end

		if (ev['location'] == nil)
			ev.merge!("location" => "no location provided")
		end

		#if theres not a end date provided, give one an hour later
		if (ev['end_time'] == nil)
			ev.merge!("end_time" => ev['start_time'].to_datetime.advance(:hours => 1))
		end

		if (ev['cover'] == nil)
			ev.merge!("cover" => "0")
		end


		venue = nil
		if (ev['venue'] != nil)
			if (ev['venue']['id'] != nil)
				venue = createVenue(ev['venue'])
			elsif (ev['venue']['name'] != nil)
				ev['location'] = ev['venue']['name']
			end
		end

		newEv = Events.find(:first, :conditions => {:fb_event_id => ev['id']})

		if (newEv == nil)
			newEv = Events.new(
				:fb_event_id => ev['id'],
				:name => ev['name'],
				:picture => ev['cover']['source'],
				:description => ev['description'],
				:start_time => ev['start_time'],
				:end_time => ev['end_time'],
				:location => ev['location'],
				:privacy => ev['privacy'],
				:updated_time => ev['updated_time'],
				:event_creator_id => event_creator.id,
				:numAttending => ev['invited']['summary']['attending_count'],
				:numInvited => ev['invited']['summary']['count'],
				:numMaybe => ev['invited']['summary']['maybe_count'],
				
			)
			if (venue != nil)
				newEv.venue_id = venue.id
			end

			if (newEv.picture == nil)
				newEv.picture = ev['picture']['data']['url']
			end
			newEv.save
			createGCal(newEv)

		else

			#array for storing which attributes need to be updated on the GCal
			update = Array.new
			#bool to keep track if needs to be saved
			needsToBeSaved = false
			
			if (newEv.name != ev['name'])
				newEv.name = ev['name']
				update.push('name')
				needsToBeSaved = true
			end

			if (ev['cover']['source'] != nil)
				if (newEv.picture != ev['cover']['source'])
					newEv.picture = ev['cover']['source']
					needsToBeSaved = true
				end
			else
				if (newEv.picture != ev['picture']['data']['url'])
					newEv.picture = ev['picture']['data']['url']
					needsToBeSaved = true
				end
			end

			if (ev['venue'] != nil)
				if ( (ev['venue']['id'] != nil) && 
					( (newEv.venue_id != nil) || (newEv.venue.vid != ev['venue']['id']) ) )
					venue = createVenue(ev['venue'])
					newEv.venue_id = venue.id
					update.push('venue')
					needsToBeSaved = true
				elsif ((ev['location']  != nil) && (newEv.location != ev['location']))
					newEv.location = ev['location']
					update.push('location')
					needsToBeSaved = true
				end
			end

			if (newEv.description != ev['description'])
				newEv.description = ev['description']
				update.push('description')
				needsToBeSaved = true
			end

			if (newEv.start_time != ev['start_time'])
				newEv.start_time = ev['start_time']
				update.push('start_time')
				needsToBeSaved = true
			end

			if (newEv.end_time != ev['end_time'])
				newEv.end_time = ev['end_time']
				update.push('end_time')
				needsToBeSaved = true
			end

			if (newEv.privacy != ev['privacy'])
				newEv.privacy = ev['privacy']
				needsToBeSaved = true
			end

			if (newEv.updated_time != ev['updated_time'])
				newEv.updated_time = ev['updated_time']
				needsToBeSaved = true
			end

			if (newEv.numAttending != ev['invited']['summary']['attending_count'])
				newEv.numAttending = ev['invited']['summary']['attending_count']
				needsToBeSaved = true
			end


			if (newEv.numMaybe != ev['invited']['summary']['maybe_count'])
				newEv.numMaybe = ev['invited']['summary']['maybe_count']
				needsToBeSaved = true
			end


			if (newEv.numInvited != ev['invited']['summary']['count'])
				newEv.numInvited = ev['invited']['summary']['count']
				needsToBeSaved = true
			end

			if (needsToBeSaved == true)
				newEv.save
			end

			if (update.length != 0)
				return updateGcalEvent(newEv, update)
			else return "Everything is up to date!"
			end

		end
	end

	def updateGcalEvent(ev, update)
		client = getGoogleClient
		service = @client.discovered_api('calendar', 'v3')
		page_token = nil
		#return ev.event_creator.cal_id
		result = client.execute(:api_method => service.events.get,
                    :parameters => {'calendarId' => ev.event_creator.cal_id, 'eventId' => ev.google_event_id})

		if (result.success? == false)
			return "Renew your Google Access Codes" + result.body
		end
		event = result.data

		update.each do |attr|
			case attr
			when 'name'
				event.summary = ev.name
			when 'start_time'
				event.start.dateTime = ev.start_time.to_s
			when 'end_time'
				event.end.dateTime = ev.end_time.to_s
			when 'description'
				event.description = ev.description.to_s + 'View the facebook event at www.facebook.com/' + ev.fb_event_id.to_s
			when 'venue'
				event.location = ev.venue.name + " " + ev.venue.street + " " + ev.venue.city + " " + ev.venue.state + " " + ev.venue.zip
			when 'location'
				event.location = ev.location
			end
		end

		result = client.execute(:api_method => service.events.update,
		                        :parameters => {'calendarId' => ev.event_creator.cal_id, 'eventId' => event.id},
		                        :body_object => event,
		                        :headers => {'Content-Type' => 'application/json'})
		return result.body
		
	end

	def createVenue(venId)
		ven = getFbGraph.get_object(venId['id'])
		venue = Venue.where(:vid => ven['id']).first_or_initialize
		venue.street = ven['location']['street']
		venue.city = ven['location']['city']
		venue.state = ven['location']['state']
		venue.zip = ven['location']['zip']
		venue.country = ven['location']['country']
		venue.longitude = ven['location']['longitude']
		venue.latitude = ven['location']['latitude']
		venue.name = ven['name']

		venue.save
		return venue
	end

=begin
	returns the FB graph
=end
	def getFbGraph()

		return Koala::Facebook::API.new(cookies.signed['fbAccessToken'])
		
	end

=begin
	returns the google client
=end
	def getGoogleClient
		client_id = ENV['GOOGLE_CAL_ID']
		client_secret = ENV['GOOGLE_CAL_SECRET']

		@client = Google::APIClient.new
		@client.authorization.client_id = client_id
		@client.authorization.client_secret = client_secret
		@client.authorization.scope = ""
		@client.authorization.refresh_token = cookies.signed['googleRefreshToken']
		@client.authorization.access_token = cookies.signed['googleAccessToken']
		

		if @client.authorization.refresh_token && @client.authorization.expired?
		  @client.authorization.fetch_access_token!
		end

		return @client
	end

=begin
	creates a google calendar event by first making sure it's not already created and
	then adding it to the cal_id
=end
	def createGCal(ev)
		client = getGoogleClient
		service = @client.discovered_api('calendar', 'v3')
		page_token = nil

		event = {
		  'summary' => ev.name,
		  'start' => {
		    'dateTime' => ev.start_time
		  },
		  'end' => {
		    'dateTime' => ev.end_time
		  },
		  'description' => ev.description.to_s + 'View the facebook event at www.facebook.com/' + ev.fb_event_id.to_s
		}

		if (ev.venue != nil)
			event.merge!('location' => ev.venue.name + " " + ev.venue.street + " " + ev.venue.city + " " + ev.venue.state + " " + ev.venue.zip)
		else 
			event.merge!('location' => ev.location)
		end


		result = client.execute(:api_method => service.events.insert,
		                        :parameters => {'calendarId' => ev.event_creator.cal_id},
		                        :body => JSON.dump(event),
		                        :headers => {'Content-Type' => 'application/json'})
		if (result.success? == false)
			ev.destroy
			return "Renew your Google Access Codes" + result.body
		end

		ev.google_event_id = result.data.id
		ev.save
		return ev.name
	end

=begin
	returns the events already in cal_id's calendar
=end
	def getCurrentEventsNames(cal_id)

		retval = ""

		if (cookies.signed['googleAccessToken'] == nil)
			return "google tokens not found";
		end

		@client = getGoogleClient
		service = @client.discovered_api('calendar', 'v3')
		page_token = nil
		result = @client.execute(:api_method => service.events.list,
		                                 :parameters => {'calendarId' => cal_id})
		names = Array.new
		while true
		  events = result.data.items

		  events.each do |e|
		  	if (e != nil)
		   		names.append(e.summary)
			end
		  end
		  if !(page_token = result.data.next_page_token)
		    break
		  end
		  result = @client.execute(:api_method => service.events.list,
		                                   :parameters => {'calendarId' => cal_id, 'pageToken' => page_token})
		end

		return names
	end
end
