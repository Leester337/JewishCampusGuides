class ProspectiveStudent < ActiveRecord::Base
  has_many :schooled
	has_many :schools, :through => :schooled
	has_many :interested_in
  has_many :interests, :through => :interested_in
  attr_accessible :bio, :education, :email, :gender, :hometown, :interests, :share_with_orgs, :link, :location, :name, :oauth_expires_at, :oauth_token, :provider, :uid

  def self.from_omniauth(auth)
    where(auth.slice(:provider, :uid)).first_or_initialize.tap do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.name = auth.info.name
      user.oauth_token = auth.credentials.token
      user.oauth_expires_at = Time.at(auth.credentials.expires_at) unless auth.credentials.expires_at.nil?
      user.save!
    end
  end
end
