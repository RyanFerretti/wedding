require 'test_helper'

class PostsControllerTest < ActionController::TestCase

  setup :initialize_user 

  test "should get index" do
    session[:user_id] = nil
    get :index
    assert_response :success
    assert_not_nil assigns(:posts)
  end

  test "should get new" do
    session[:user_id] = @user.id
    get :new
    assert_response :success
  end

  test "should create post" do
    session[:user_id] = @user.id
    assert_difference('Post.count') do
      post :create, :post => { :title => 'title', :body => 'body' }
    end

    assert_redirected_to post_path(assigns(:post))
  end

  test "should show post" do
    session[:user_id] = nil
    get :show, :id => posts(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    session[:user_id] = @user.id
    get :edit, :id => posts(:one).to_param
    assert_response :success
  end

  test "should update post" do
    session[:user_id] = @user.id
    put :update, :id => posts(:one).to_param, :post => { }
    assert_redirected_to post_path(assigns(:post))
  end

  test "should destroy post" do
    session[:user_id] = @user.id
    assert_difference('Post.count', -1) do
      delete :destroy, :id => posts(:one).to_param
    end

    assert_redirected_to posts_path
  end

  private
  def initialize_user
    attributes = {}
    attributes[:username] ||= 'ryan'
    attributes[:email] ||= 'ryan@example.com'
    attributes[:password] ||= 'abc123'
    attributes[:password_confirmation] ||= attributes[:password]
    @user = User.create(attributes)
  end
end
