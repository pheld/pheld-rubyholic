class AddUrlAndDescriptionToGroups < ActiveRecord::Migration
  def self.up
    add_column :groups, :url, :text
    add_column :groups, :description, :text
  end

  def self.down
    remove_column :groups, :url
    remove_column :groups, :description
  end
end
