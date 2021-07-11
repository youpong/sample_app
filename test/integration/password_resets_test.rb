require 'test_helper'

class PasswordResetsTest < ActionDispatch::IntegrationTest

  def setup
    ActionMailer::Base.deliveries.clear
    @user = users(:michael)
  end
  
  test "password resets" do
    get new_password_reset_path
    assert_template 'password_resets/new'
    assert_select 'input[name=?]', 'password_reset[email]'

    #
    # Forgot password form
    #
    
    # invalid email
    post password_resets_path, params: { password_reset: { email: "" } }
    assert flash.any?
    assert_template 'password_resets/new'

    # valid email
    post password_resets_path,
         params: { password_reset: { email: @user.email } }
    assert_not_equal @user.reset_digest, @user.reload.reset_digest
    assert_equal 1, ActionMailer::Base.deliveries.size
    assert flash.any?
    assert_redirected_to root_url

    #
    # reset password form
    #
    
    user = assigns(:user)

    # invalid email
    get edit_password_reset_path(user.reset_token, email: "")
    assert_redirected_to root_url
    
    # non-activated user
    user.toggle!(:activated)
    get edit_password_reset_path(user.reset_token, email: user.email)
    assert_redirected_to root_url
    user.toggle!(:activated)    

    # invalid reset token
    get edit_password_reset_path("wrong token", email: user.email)
    assert_redirected_to root_url

    # valid combination reset token/email
    get edit_password_reset_path(user.reset_token, email: user.email)
    assert_template 'password_resets/edit'
    assert_select "input[name=email][type=hidden][value=?]", user.email
    
    # password/password_confirmation combination doesn't match
    patch password_reset_path(user.reset_token),
           params: { email: user.email,
                     user: { password: "foobaz",
                             password_confirmation: "barquux" } }
    assert_select 'div#error_explanation'

    # blank password/password_confirmation
    patch password_reset_path(user.reset_token),
           params: { email: user.email,
                     user: { password: "",
                             password_confirmation: "" } }
    assert_select 'div#error_explanation'

    # valid password/password_confirmation
    patch password_reset_path(user.reset_token),
          params: { email: user.email,
                    user: { password: "foobaz",
                            password_confirmation: "foobaz" } }
    assert is_logged_in?
    assert flash.any?
    assert_redirected_to user
  end
end
