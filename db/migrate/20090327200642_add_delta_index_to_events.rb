class AddDeltaIndexToEvents < ActiveRecord::Migration
  def self.up
    add_column :events, :delta, :boolean, :default => false
  end

  def self.down
    remove_column :events, :delta
  end
end
