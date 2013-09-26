require 'test_helper'

class RepliesControllerTest < ActionController::TestCase
  setup do
    @reply = replies(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:replies)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create reply" do
    assert_difference('Reply.count') do
      post :create, reply: { description: @reply.description, id: @reply.id, num_likes: @reply.num_likes, post_id: @reply.post_id, temp_r: @reply.temp_r }
    end

    assert_redirected_to reply_path(assigns(:reply))
  end

  test "should show reply" do
    get :show, id: @reply
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @reply
    assert_response :success
  end

  test "should update reply" do
    put :update, id: @reply, reply: { description: @reply.description, id: @reply.id, num_likes: @reply.num_likes, post_id: @reply.post_id, temp_r: @reply.temp_r }
    assert_redirected_to reply_path(assigns(:reply))
  end

  test "should destroy reply" do
    assert_difference('Reply.count', -1) do
      delete :destroy, id: @reply
    end

    assert_redirected_to replies_path
  end
end
