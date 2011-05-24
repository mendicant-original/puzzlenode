Factory.define :puzzle do |p|
  p.name              "Puzzle"
  p.short_description "Test Puzzle"
  p.description       "This is a test puzzle.  It doesn't actually do anything."
  p.file              Tempfile.new("test_tempfile")
end
