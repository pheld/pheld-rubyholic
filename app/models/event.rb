class Event < ActiveRecord::Base
  belongs_to :group
  belongs_to :location
  
  named_scope :by_name, :order => 'name'
  named_scope :by_group_name, :include => [:group], :order => 'groups.name'
  named_scope :by_location_name, :include => [:location], :order => 'locations.name'
end