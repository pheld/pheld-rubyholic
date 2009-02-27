class CreateLocations < ActiveRecord::Migration
  def self.up
    create_table :locations do |t|
      t.string :name
      t.string :address
      t.integer :latitude
      t.integer :longitude
      t.string :notes

      t.timestamps
    end
  end

  def self.down
    drop_table :locations
  end
end
