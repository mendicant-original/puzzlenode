require 'test_helper'

module Admin
  class UsersTest < ActionDispatch::IntegrationTest
    
    setup do
      OmniAuth.config.add_mock(:github, {:uid => '12345', :nickname => "PN User"})
    end
    
    test "Admin users can edit other users" do
      #other_user = Factory(:user, :admin => false, :name => "Edit Me")
      
      visit root_path
      assert_current_path "/"

      sign_user_in
      
      assert_content "Log out"
    end
  end
end
