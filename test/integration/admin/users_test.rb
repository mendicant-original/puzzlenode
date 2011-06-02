require 'test_helper'

module Admin
  class UsersTest < ActionDispatch::IntegrationTest

    setup do
      @admin_user = Factory(:user, :admin => true)
      @admin_user.authorizations.create(:provider => "github", :uid => "12345")
    end

    test "Admin users can edit other users" do
      other_user = Factory(:user, :admin => false, :name => "Edit Me", :nickname => "Edit Me")

      sign_user_in

      visit edit_admin_user_path(other_user.id)

      assert_content "Edit User"

      check "Admin"

      click_button "Update User"

      assert_current_path admin_user_path(other_user)

      assert other_user.reload.admin, "Other user not set to admin!"
    end
  end
end
