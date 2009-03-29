class AddDeltaIndexToGroups < ActiveRecord::Migration
  def self.up
    add_column :groups, :delta, :boolean, :default => false
  end

  def self.down
    remove_column :groups, :delta
  end
end
