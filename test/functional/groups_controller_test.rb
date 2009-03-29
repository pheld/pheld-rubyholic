require 'test_helper'

class GroupsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:groups)
  end
  
  test "should show existing groups in index" do
    get :index
    assert_response :success
    assert_match("a group", @response.body)
    assert_match("b group", @response.body)
    assert_match("c group", @response.body)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create group" do
    assert_difference('Group.count') do
      post :create, :group => { }
    end

    assert_redirected_to group_path(assigns(:group))
  end

  test "should show group" do
    get :show, :id => groups(:one).id
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => groups(:one).id
    assert_response :success
  end

  test "should update group" do
    put :update, :id => groups(:one).id, :group => { }
    assert_redirected_to group_path(assigns(:group))
  end

  test "should destroy group" do
    assert_difference('Group.count', -1) do
      delete :destroy, :id => groups(:one).id
    end

    assert_redirected_to groups_path
  end
  
  test "should look up list of events for shown group" do
    get :show, :id => groups(:one).id
    assert_response :success
    
    # assert that the @events variable has been assigned
    assert assigns(:events)
    
    # assert that the correct events are associated with this group
    assert_equal(2, assigns(:events).length)
    assert_equal('b event', assigns(:events)[0].name)
  end
  
  test "should generate the google map url if there are events associated with this group" do
    get :show, :id => groups(:one).id
    assert_response :success
    
    # assert that the @google_maps_url variable has been assigned
    assert assigns(:google_maps_url)
    
    assert_equal("http://maps.google.com/staticmap?size=512x512\&markers=47.618235,-122.350866%7C47.618235,-122.350866&key=#{GOOGLE_MAPS_KEY}&sensor=false", assigns(:google_maps_url))
  end
  
  test "should return groups in ascending order by default" do
    get :index, :page_size => '1'
    
    # only the 'c group' should be returned
    assert_match("a group", @response.body)
    assert_no_match(/b\ group/, @response.body)
    assert_no_match(/c\ group/, @response.body)
  end
  
  test "should return groups in the specified order" do
    get :index, :sort_dir => 'DESC', :page_size => '1'
    
    # only the 'c group' should be returned
    assert_no_match(/a\ group/, @response.body)
    assert_no_match(/b\ group/, @response.body)
    assert_match("c group", @response.body)
  end
  
  test "should return the matching groups when a search term is specified" do
    get :index, :search => "c group"
    
    # only the 'c group' should be returned
    assert_no_match(/a\ group/, @response.body)
    assert_no_match(/b\ group/, @response.body)
    assert_match("c group", @response.body)
  end
  
  test "should return the first page of groups using will_paginate" do
    get :index, :sort_dir => 'ASC', :page_size => '2'
    
    # only the first two groups are shown
    assert_match("a group", @response.body)
    assert_match("b group", @response.body)
    assert_no_match(/c\ group/, @response.body)
  end

  test "should return the second page of groups using will_paginate" do
    get :index, :sort_dir => 'ASC', :page_size => '2', :page => '2'
    
    # only the first two groups are shown
    assert_no_match(/a\ group/, @response.body)
    assert_no_match(/b\ group/, @response.body)
    assert_match("c group", @response.body)
  end
end
