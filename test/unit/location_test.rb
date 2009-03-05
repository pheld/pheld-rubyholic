require 'test_helper'

class LocationTest < ActiveSupport::TestCase
  test "a location can be created" do
    assert_difference('Location.count') do
      location = Location.new(
        :name => "new location",
        :address => "213 Wharf Ave.",
        :latitude => "123",
        :longitude => "456",
        :notes => "new notes"
      )
      location.save
    end
  end
end
