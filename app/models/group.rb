class Group < ActiveRecord::Base
  has_many :events
  has_many :locations, :through => :events
  
  named_scope :by_name, :order => 'name'    
  
  def self.search(search)
    if search
      find(:all, :conditions => ['name LIKE ? OR description LIKE ? OR url LIKE ?', "%#{search}%", "%#{search}%", "%#{search}%"])
    else
      find(:all)
    end
  end
end
