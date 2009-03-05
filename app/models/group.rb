class Group < ActiveRecord::Base
  has_many :events
  has_many :locations, :through => :events
  
  named_scope :by_name, :order => 'name'    
end
