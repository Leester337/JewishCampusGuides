module CollegesHelper
  def title(page_title)
    content_for :title, page_title.to_s
  end

  def jewishMajorMinor()
    jewishAcad = ""
    if (@college.jewishMajor == true)
      if (@college.jewishMinor == true)
        jewishAcad = "Minor and major available"
      else
        jewishAcad = "Major available"
      end
    elsif (@college.jewishMinor == true)
      jewishAcad = "Minor available"
    else jewishAcad = "No Jewish degrees available"
    end

    return jewishAcad
  end

  def checkStudentSubmit
    if (params.has_key?(:prospective_major))
      return saveStudentInfo(params[:prospective_major])
    else return ""
    end
  end

  def saveStudentInfo(major)

    if (!current_user)
      return "Please sign into Facebook first!"
    end

    graph = Koala::Facebook::API.new(current_user.oauth_token)
    query = "me?fields=about,bio,education,email,gender,hometown,link,location,name,interests"
    me = graph.get_object(query)

    current_user.gender = me['gender']
    current_user.link = me['link']
    current_user.bio = me['bio']
    me['education'].each do |sch|
      currSch = School.where(:fid => sch['school']['id']).first_or_create(:name => sch['school']['name'], :school_type => sch['type'])
      schooled = Schooled.where(:prospective_student_id => current_user.id, :school_id => currSch.id).first_or_initialize()

      schooled.degree =sch['degree']['name'] unless sch['degree'].nil?
      schooled.year = sch['year']['name'] unless sch['year'].nil?
      schooled.concentration = sch['concentration'][0]['name'] unless sch['concentration'].nil?

      schooled.save

    end

    current_user.email = me['email']
    current_user.hometown = me['hometown']['name'] unless me['hometown'].nil?
    current_user.location = me['location']['name'] unless me['location'].nil?
    me['interests'].each unless me['interests'].nil? do |int|
      newInt = Interest.where(:fid => int['id']).first_or_create(:name => int['name'], :category => int['category'])
      newInt_in = Interested_In.where(:prospective_student_id => current_user.id, :interest_id => newInt.id).first_or_create
    end
    current_user.major = params[:prospective_major]
    current_user.share_with_orgs = params[:share]

    current_user.save

    StudentMailer.send_student(current_user, @college.rep_email).deliver
    return nil
  end

  InitializeRow = "
        <div class='row-fluid'>
          <div class='span2'>
          </div>

          <div class='span10'>"

  def createHeader header
    return "<h4 class='text-center' id='#{header.gsub(/\s+/, "")}'>#{header}</h4><br>"
  end

=begin
    Creates the beginning of a list of thumbnails
=end
  BeginThumbnailSet = "<ul id='peopleThumbnails' class='thumbnails'>"

=begin
    Create the list element of each thumbnail with the image
=end
  def startIndivThumbnail image
    return "
              <li class='span3'>
                <div class='thumbnail'>
                  <img id='peopleImg' src= #{image} >
                  <div class='caption'> "
  end

  def createOrganizations
    orgs = Organization.where('college_id' => @college.id)
    setupGroupsOfThumbnails(orgs, "Organizations")
  end

  def createCampusLeaders
     campusLeaders = CampusLeader.joins(:organization => :college).where('colleges.id' => @college.id).all
     setupGroupsOfThumbnails(campusLeaders, "People to Know")
  end

  def createLeaderCaption(lead)
    retval = "<h5> #{lead.name} </h5>
    <p id='moveLeft'><strong>Works for:</strong> #{lead.organization.name} </p>"

    if (!lead.bio.nil? && (!lead.bio.empty?))
      retval << "<p id='moveLeft'><strong>Bio:</strong> " << lead.bio << "</p>"
    end

    if (!lead.hometown.nil? && (!lead.hometown.empty?))
      retval << "<p id='moveLeft'><strong>Hometown:</strong> " << lead.hometown << "</p>"
    end

    if (!lead.significant_other.nil? && (!lead.significant_other.empty?))
      retval << "<p id='moveLeft'><strong>Significant Other:</strong> " << lead.significant_other << "</p>"
    end

    if (!lead.quote.nil? && (!lead.quote.empty?))
      retval << "<p id='moveLeft'><strong>Favorite Quotes:</strong> " << lead.quote << "</p>"
    end

    if (!lead.email.nil? && (!lead.email.empty?))
      retval << "<center><strong>Email:</strong> <p>" << lead.email << "</p></center>"
    end

    return retval
  end

  CreateEndThumbnailItem = "</div> </div> </li>"

  FinishThumbnailList = "</ul> </div> </div>"

  def createOrganizationCaption(org)
    retval = "<h5> #{org.name} </h5>"

    if (!org.venue.nil?)
      retval << "<p id='moveLeft'><strong>Located at:</strong> " << org.venue.street << " " << 
        org.venue.city << " " << org.venue.state << " " << org.venue.zip << "</p>"
    end

    return retval
  end

=begin
  Iterates through all the elements and determine how many rows are necessary and will call
  the necessary functions to create them
=end
  def setupGroupsOfThumbnails(items, header)
   
    lastItem = items.size - 1
    currItem = 0

    retval = ""
    items.each do |item|
      #if a new row should be made
      if (currItem%3 == 0)
        retval << InitializeRow

          #if this is the first item, add the section heading
          if (currItem == 0)
            retval << createHeader(header)
        end

        retval << BeginThumbnailSet
    end

    
    retval << startIndivThumbnail(item.picture) 
    case header
    when  "Organizations"
        retval << createOrganizationCaption(item)
    when "People to Know"
        retval << createLeaderCaption(item) 
    end

    retval << CreateEndThumbnailItem


    if (currItem == lastItem || currItem%3 == 2)
        retval << FinishThumbnailList
    end

    currItem += 1
end 

return retval.html_safe    
  end

  def createThumbnails
    

  end

end
