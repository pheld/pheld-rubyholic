class Group < ActiveRecord::Base
  has_many :events
  has_many :locations, :through => :events
  
  named_scope :by_name, :order => 'name'    
  
  # Sphinx index definitions
  define_index do
    indexes name, :sortable => true
    indexes url
    indexes description
    
    has created_at, updated_at, type
    
    set_property :delta => true
  end

  # will-paginate
  def self.per_page
    2
  end
  
  # def self.search(search)
  #   if search
  #     find(:all, :conditions => ['name LIKE ? OR description LIKE ? OR url LIKE ?', "%#{search}%", "%#{search}%", "%#{search}%"])
  #   else
  #     find(:all)
  #   end
  # end
end
