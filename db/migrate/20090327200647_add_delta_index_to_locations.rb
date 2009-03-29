class AddDeltaIndexToLocations < ActiveRecord::Migration
  def self.up
    add_column :locations, :delta, :boolean, :default => false
  end

  def self.down
    remove_column :locations, :delta
  end
end
