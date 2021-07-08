require 'test_helper'

class UsersEditTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:michael)
  end

  test "successful edit" do
    log_in_as(@user)
    get edit_user_path(@user)
    assert_template 'users/edit'
    name = "Foo Bar"
    email = "foo@bar.com"
    patch user_path(@user), params: {
            user: { name: name, email: email,
                    password: "", password_confirmation: "" } }
    assert flash.any?
    assert_redirected_to @user
    @user.reload
    assert_equal name, @user.name
    assert_equal email, @user.email
  end

  test "unsuccessful edit" do
    log_in_as(@user)    
    get edit_user_path(@user)
    assert_template 'users/edit'
    patch user_path(@user), params: {
                              user: { name: "",
                                      email: "foo@invalid",
                                      password: "foo",
                                      password_confirmation: "bar" } }
    assert_template 'users/edit'
    # assert_select 'div.alert'
    assert_select 'div.alert-danger', /4 errors/
    # assert_select 'div.alert-danger', 'The form contains 4 errors.'
  end

end
