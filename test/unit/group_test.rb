require 'test_helper'

class GroupTest < ActiveSupport::TestCase
  test "a group can be created" do
    assert_difference('Group.count') do
      group = Group.new(:name => "new group")
      group.save
    end
  end
  
  test "groups can be sorted by name" do
    # default sort
    groups = Group.find(:all)
    assert_equal("c group", groups[0].name)
    
    # sorted by name
    groups = Group.by_name
    assert_equal("a group", groups[0].name)
  end
end
