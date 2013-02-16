require 'test_helper'

module Admin
  class UsersTest < ActionDispatch::IntegrationTest

    setup do
      @admin_user = FactoryGirl.create(:user, :admin => true)
      @admin_user.authorizations.create(:provider => "github", :uid => "12345")
    end

    test "Admin users can make other users admins" do
      other_user = FactoryGirl.create(:user, :admin => false, :name => "Edit Me", :nickname => "Edit Me")

      sign_user_in

      visit edit_admin_user_path(other_user.id)

      assert_content "Edit Me"

      check "Admin"

      click_button "Update User"

      assert_current_path admin_users_path

      assert other_user.reload.admin, "Other user not set to admin!"
    end

    test "Admin users can grant draft access to other users" do
      other_user = FactoryGirl.create(:user, :draft_access => false, :name => "Edit Me", :nickname => "Edit Me")

      sign_user_in

      visit edit_admin_user_path(other_user.id)

      assert_content "Edit Me"

      check "Draft access"

      click_button "Update User"

      assert_current_path admin_users_path

      assert other_user.reload.draft_access, "Other user not set to admin!"
    end
  end
end
