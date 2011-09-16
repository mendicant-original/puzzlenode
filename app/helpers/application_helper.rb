module ApplicationHelper

  def title(page_title)
    content_for(:title) { page_title }
  end

  def md(content,  options={})
    markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML,
      :autolink            => true,
      :space_after_headers => true,
      :no_intra_emphasis   => true,
      :fenced_code_blocks  => true)

    html = markdown.render(content)

    # FIXME Use Redcarpet to strip p tags
    html = html.gsub(/<\/?p>/, '') if options[:no_p]

    html.html_safe
  end

end
