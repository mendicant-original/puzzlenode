FactoryGirl.define do
  factory :user do |u|
    u.name                "PN User"
    u.nickname            "PN User"
    u.email               "user@example.com"
    u.notify_comment_made true
  end

  factory :puzzle do |p|
   p.name              "Puzzle"
    p.sequence(:slug)   { |n| "puzzle-#{n}" }
    p.short_description "Test Puzzle"
    p.description       "This is a test puzzle.  It doesn't actually do anything."
    p.tag_list          "Game, Graphics"
    p.file              Tempfile.new("test_tempfile")
    p.released_on       DateTime.yesterday
    p.published         true
  end

end
