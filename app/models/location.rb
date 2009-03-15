class Location < ActiveRecord::Base
  include Geokit::Geocoders
  
  acts_as_mappable  :lat_column_name => :latitude,
                    :lng_column_name => :longitude
  
  has_many :events
  has_many :groups, :through => :events

  def self.coords_from_address(address)
    result = nil
    
    unless address.nil?
      loc = YahooGeocoder.geocode(address)
      result = []
      result[0] = loc.lat
      result[1] = loc.lng
    end
    
    result    
  end
end
