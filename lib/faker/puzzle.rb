module Faker
  module Puzzle
    # This module uses several magic numbers to represent the relative frequencies
    # of structures as seen in actual puzzles, as seen by actual eyeballs.

    def fake_paragraphs
      p = []

      (1 + rand(3)).times do
        p << Faker::Lorem.paragraph(4 + rand(8))
      end

      p.join("\n\n")
    end

    def fake_sentence
      Faker::Lorem.sentence
    end

    def fake_email
      Faker::Internet.email
    end

    def fake_name
      Faker::Name.name
    end

    def fake_nickname
      Faker::Name.first_name.downcase
    end

    def fake_sentences
      Faker::Lorem.sentences(3 + rand(5)).join("\n")
    end

    def fake_list
      Faker::Lorem.sentences(3 + rand(5)).map{|s| '* ' + s}.join("\n")
    end

    def fake_title
      Faker::Lorem.words(2 + rand(4)).join(' ').titleize
    end

    def fake_heading
      # Use h2 in this context. h1 ought to be reserved for parent elements
      '## ' + fake_title
    end

    # <pre><code> requires a code fence extension to Markdown as used in
    # GFM/Redcarpet - the preferred method because the default of using legacy
    # four-space "tabs" to indent two-space indented code is irritating

    def fake_code_block
      ["````",
       fake_sentences,
       "````"].join("\n")
    end

    def fake_description
      text = [fake_paragraphs]

      (3 + rand(5)).times do
        text << fake_heading
        text << fake_paragraphs

        case rand(3)
        when 0
          text << fake_paragraphs
        when 1
          text << fake_list
        when 2
          text << fake_code_block
        end
      end

      text.join("\n\n")
    end
  end
end
