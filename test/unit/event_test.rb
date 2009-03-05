require 'test_helper'

class EventTest < ActiveSupport::TestCase
  test "an event can be created" do
    assert_difference('Event.count') do
      event = Event.new(
        :name => "new event",
        :description => "new description",
        :start_date => "090101",
        :end_date => "090201"
      )
      event.save
    end
  end
  
  test "events can be sorted by name" do
    # default sort
    events = Event.find(:all)
    assert_equal("c event", events[0].name)
    
    # sorted by name
    events = Event.by_name
    assert_equal("a event", events[0].name)
  end
  
  test "events can be sorted by group name" do
    events = Event.by_group_name
    assert_equal("c event", events[0].name)
    assert_equal("a event", events[1].name)
    assert_equal("b event", events[2].name)
  end
  
  test "events can be sorted by location name" do
    events = Event.by_location_name
    assert_equal("b event", events[0].name)
    assert_equal("c event", events[1].name)
    assert_equal("a event", events[2].name)
  end
end
