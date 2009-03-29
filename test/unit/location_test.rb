require 'test_helper'

class LocationTest < ActiveSupport::TestCase
  def setup
    @valid_location = Location.new(
      :name => "valid location",
      :address => "2901 3rd Ave, Seattle, WA 98121",
      :notes => "valid location notes"
      )
  end
  
  test "a location can be created" do
    assert_difference('Location.count') do
      location = Location.new(
        :name => "new location",
        :address => "213 Wharf Ave.",
        :latitude => "123.313",
        :longitude => "456.223",
        :notes => "new notes"
      )
      location.save
    end
  end
  
  # NEEDS A CONNECTION TO THE INTERNETS! :(
  test "a location can return latitude and longitude given a valid address" do
    # the correct lat/lng should be 47.618235/-122.350866
    coords = Location.coords_from_address(@valid_location.address)
    assert_equal(47.618235, coords[0])
    assert_equal(-122.350866, coords[1])
  end
end
