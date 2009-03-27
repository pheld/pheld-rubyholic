class Location < ActiveRecord::Base
  include Geokit::Geocoders
  
  acts_as_mappable  :lat_column_name => :latitude,
                    :lng_column_name => :longitude
  
  has_many :events
  has_many :groups, :through => :events
  
  # Sphinx index definitions
  define_index do
    indexes name, :sortable => true
    indexes address
    indexes notes, :sortable => true
    
    has created_at, updated_at, longitude, latitude
  end
  
  # will-paginate
  def self.per_page
    5
  end

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
