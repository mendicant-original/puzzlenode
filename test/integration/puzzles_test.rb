require 'test_helper'

class PuzzlesTest < ActionDispatch::IntegrationTest

  setup do
    @user = Factory(:user)
    @puzzle = Factory(:puzzle)
    @user.authorizations.create(:provider => "github", :uid => "12345")
  end
  
  test "show submissions stats" do
    [false, true].each{|result| create_submission(@puzzle, @user, result) }
    
    sign_user_in
    
    visit puzzle_path(@puzzle)
    
    assert_content "1 / 2 correct submissions"
  end
  
end