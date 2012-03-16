module MdPreview
  module CustomParser
    extend self

    def parse(content)
      markdown = Redcarpet::Markdown.new(MdEmoji::Render,
              :autolink            => true,
              :space_after_headers => true,
              :no_intra_emphasis   => true,
              :fenced_code_blocks  => true)

      markdown.render(content).html_safe
    end
  end
end