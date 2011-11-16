xml.instruct! :xml, :version => "1.0"
xml.rss :version => "2.0",  'xmlns:atom' => "http://www.w3.org/2005/Atom" do
  xml.channel do
    xml.title "PuzzleNode"
    xml.description "PuzzleNode is a quiz site inspired by Project Euler and the Internet Problem Solving Contest (IPSC)"
    xml.link "http://puzzlenode.com"
    xml.send('atom:link', :href => "http://puzzlenode.com/announcements.rss", :rel => "self", :type => "application/rss+xml")
    @announcements.each do |announcement|
      xml.item do
        xml.title announcement.title
        xml.description md(announcement.body)
        xml.author announcement.author.name
        xml.pubDate announcement.created_at.to_s(:rfc822)
        xml.link "http://puzzlenode.com/announcements/#{announcement.id}"
        xml.guid "http://puzzlenode.com/announcements/#{announcement.id}"
      end
    end
  end
end