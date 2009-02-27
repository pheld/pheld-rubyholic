class AddForeignKeysToEvents < ActiveRecord::Migration
  def self.up
    add_column :events, :group_id, :integer
    add_column :events, :location_id, :integer
  end

  def self.down
    remove_column :events, :group_id
    remove_column :events, :location_id
  end
end
