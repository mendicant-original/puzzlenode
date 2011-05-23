require 'test_helper'

module Admin
  class UsersTest < ActionDispatch::IntegrationTest
    
    setup do
      @admin_user = Factory(:user, :admin => true)
      @admin_user.authorizations.create(:provider => "github", :uid => "12345")
    end
    
    test "Admin users can edit other users" do      
      other_user = Factory(:user, :admin => false, :name => "Edit Me", :nickname => "Edit Me")
      
      visit root_path
      assert_current_path "/"

      sign_user_in
      
      assert_content "Log out"
      
      visit edit_admin_user_path(other_user.id)
      
      assert_content other_user.name
      
      check "user_admin"
      click_button "Save"
      
      assert_current_path admin_users_path
      
      assert other_user.reload.admin, "Other user not set to admin!"
    end
  end
end
