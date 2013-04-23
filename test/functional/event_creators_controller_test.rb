require 'test_helper'

class EventCreatorsControllerTest < ActionController::TestCase
  setup do
    @event_creator = event_creators(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:event_creators)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create event_creator" do
    assert_difference('EventCreator.count') do
      post :create, event_creator: { collegeNickname: @event_creator.collegeNickname, fbId: @event_creator.fbId, name: @event_creator.name }
    end

    assert_redirected_to event_creator_path(assigns(:event_creator))
  end

  test "should show event_creator" do
    get :show, id: @event_creator
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @event_creator
    assert_response :success
  end

  test "should update event_creator" do
    put :update, id: @event_creator, event_creator: { collegeNickname: @event_creator.collegeNickname, fbId: @event_creator.fbId, name: @event_creator.name }
    assert_redirected_to event_creator_path(assigns(:event_creator))
  end

  test "should destroy event_creator" do
    assert_difference('EventCreator.count', -1) do
      delete :destroy, id: @event_creator
    end

    assert_redirected_to event_creators_path
  end
end
