require 'test_helper'

class UserSignupTest < ActionDispatch::IntegrationTest
 test "invalid signup information" do
   get signup_path
   assert_no_difference 'User.count' do
     post users_path, user: {name: "",
                    email: "user@invalid",
                    password: "co",
                    password_confirmation: "as"}
   end
   assert_template 'users/new'
   assert_select 'div#error_explanation'
   assert_select 'div.field_with_errors'
   end
  test "valid signup" do
    assert_difference 'User.count', 1 do
      post_via_redirect users_path, user: {name: "Valid Name",
                              email: "valid@em.ail",
                              password: "correctpassword",
                              password_confirmation: "correctpassword"}
    end
    assert_template 'users/show'
    assert_not flash.empty?
    assert is_logged_in?
  end
end
